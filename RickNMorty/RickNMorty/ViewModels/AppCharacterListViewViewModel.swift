//
//  CharacterListViewViewModel.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 4.07.2023.
//

import UIKit

protocol AppCharacterListViewModelDelegate: AnyObject {
    func didLoadInitialCharacter()
    func didSelectCharacter(_ character: AppCharacters)  //for going into detailed view
    
}
///  View Model to handle character list view logic
final class AppCharacterListViewViewModel:NSObject {
    
    public weak var delegate: AppCharacterListViewModelDelegate?
    
    private var characters: [AppCharacters] = [] {
        didSet {
            for character in characters {
                let viewModel = AppCharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image)
                )
                cellViewModels.append(viewModel)
        
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
    public func fetchAdditionalCharacters(){
        // fetch new characters
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppCharacterCollectionViewCell.cellidentifier, for: indexPath) as? AppCharacterCollectionViewCell else {
            fatalError("Unsupported Cell")
        }
        let viewModel = cellViewModels[indexPath.row]
        
        cell.configure(with: viewModel)
        return cell
    }
 
}
// MARK: - Collectionview delegate

extension AppCharacterListViewViewModel:UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(
            width: width,
            height: width * 1.5)
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
        //
        guard shouldLoadMoreIndicator else {
            return
        }
    }
}

// MARK: - CollectionView Footer
/// to install new chars, adjusting a footer
extension AppCharacterListViewViewModel {
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter, shouldLoadMoreIndicator else {
            return UICollectionReusableView()
        }
        
        let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: AppFooterLoadingCollectionReusableView.identifier, for: indexPath)
        
        return footer
    }
    /// resize the footer
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}


