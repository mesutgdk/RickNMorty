//
//  CharacterListViewViewModel.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 4.07.2023.
//

import UIKit

protocol AppCharacterListViewModelDelegate: AnyObject {
    func didLoadInitialCharacter()
    func didSelectCharacter(_ character: AppCharacter)  //for going into detailed view
    func didLoadMoreCharacters(with newIndexPath:[IndexPath])
}
///  View Model to handle character list view logic
final class AppCharacterListViewViewModel:NSObject {
    
    var isList: Bool = true
    
    public weak var delegate: AppCharacterListViewModelDelegate?
    
    private var isLoadingMoreCharacters = false
    
    private var characters: [AppCharacter] = [] {
        didSet {
//            print("Creating viewModels!")
            for character in characters {
                let viewModel = AppCharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image)
                )
//               tekrar eklenmesinin önüne geçmek için
                if !cellViewModels.contains(viewModel) {
                    
                    cellViewModels.append(viewModel)
                    
                }
            }
        }
    }
    
    private var cellViewModels: [AppCharacterCollectionViewCellViewModel] = []
    
    private var apiInfo: AppGetAllCharactersResponse.Info? = nil
    
    /// Fetch initial set of characters (20 items)
    public func fetchCharacters(){
        AppService.shared.execute(.listCharacterRequests, expecting: AppGetAllCharactersResponse.self) { [weak self] result in
            switch result {
            case .success(let responceModel):
                let results = responceModel.results
                let info = responceModel.info
                self?.characters = results
                self?.apiInfo = info
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacter()   // it will trigger update view so main thread
                }
               
                
//                print("Example image url : "+String(model.results.first?.image ?? " No image "))
//                print("Page result count: "+String(model.results.count))
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    /// Paginate if additional characters are needed
    public func fetchAdditionalCharacters(url:URL){
        // ensure it is false, fetch new characters
        guard !isLoadingMoreCharacters else{
            return
        }
//        print("fetching more characters")

        isLoadingMoreCharacters = true
        
        guard let request = AppRequest(url: url) else {
            isLoadingMoreCharacters = false
            print("Failed to create a request")
            return
        }
        
        AppService.shared.execute(request, expecting: AppGetAllCharactersResponse.self) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let responseModel):
//                print("pre-update:\(strongSelf.cellViewModels.count)")
                
                let moreResults = responseModel.results
                let info = responseModel.info
                strongSelf.apiInfo = info
             
                let originalCount = strongSelf.characters.count
                let newCount  = moreResults.count
                let totalCount = originalCount + newCount
                let startingIndex = totalCount - newCount
                
//                strongSelf.apiInfo = info


                let indexPathsToAdd: [IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap {
                    return IndexPath(row: $0, section: 0)
                }
//                print("char = \(originalCount)", "newchars= \(newCount)", "totalchar= \(totalCount)")
//                print(indexPathsToAdd.count)
                
                strongSelf.characters.append(contentsOf: moreResults)
                
//                print("ViewModels: \(strongSelf.cellViewModels.count)")
                
                DispatchQueue.main.async {

                    strongSelf.delegate?.didLoadMoreCharacters(with: indexPathsToAdd)
                    strongSelf.isLoadingMoreCharacters = false

                }
     
            case .failure(let failure):
                print(String(describing: failure))
                strongSelf.isLoadingMoreCharacters = false
            }
        }

    }
    
    private var shouldLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
}
// MARK: - CollectionView datasource

extension AppCharacterListViewViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if !isList {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppCharacterCollectionGridViewCell.cellIdentifier, for: indexPath) as? AppCharacterCollectionGridViewCell else {
                fatalError("Unsupported Cell")
                
            }
            let viewModel = cellViewModels[indexPath.row]
            
            cell.configure(with: viewModel)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppCharacterCollectionListViewCell.cellIdentifier, for: indexPath) as? AppCharacterCollectionListViewCell else {
                fatalError("Unsupported Cell")
            }
            let viewModel = cellViewModels[indexPath.row]
            
            cell.configure(with: viewModel)
            return cell
        }
       
    }
 
}
// MARK: - Collectionview delegate

extension AppCharacterListViewViewModel:UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let isIphone = UIDevice.current.userInterfaceIdiom == .phone
        
        let bounds = collectionView.bounds
        let width : CGFloat
        if !isList{
            //iphone
            if isIphone{
                width = (bounds.width-50)/2
                return CGSize(
                    width: width,
                    height: width * 1.2)
            }
            //mac|| ipad
            width = (bounds.width-50)/4
            return CGSize(
                width: width,
                height: width * 1.2)
        } else {
            let width = bounds.width-16
            return CGSize(
                width: width,
                height: 100)
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        delegate?.didSelectCharacter(character)
    }
}

// MARK: - ScrollView
extension AppCharacterListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard shouldLoadMoreIndicator,
              !isLoadingMoreCharacters,
              !cellViewModels.isEmpty,
              let nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString) else {
            return
        }
        /*
         offset scrollview'in y uç noktası
         if statument: gives us that the edge of the scrollview and updates the page
         -120 is the size of footer's y
          we dicard to fetch n times with using isLoadingMoreChar in fetchAdCh, after using isLo it works only one times
        */
        // timer is for the problem that offset detects top
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] tmr in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height

            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
                self?.fetchAdditionalCharacters(url:url)
            }
            tmr.invalidate()
        }
        
        
    }
}

// MARK: - CollectionView Footer
/// to install new chars, adjusting a footer
extension AppCharacterListViewViewModel {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
                let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: AppFooterLoadingCollectionReusableView.identifier,
                                                                             for: indexPath
                ) as? AppFooterLoadingCollectionReusableView else {
            fatalError("Unsupported")
        }
        
        footer.startAnimatiıng()
        
        return footer
    }
    /// resize the footer
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldLoadMoreIndicator else {
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}


