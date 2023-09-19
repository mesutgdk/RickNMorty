//
//  AppEpisodeListViewViewModel.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 14.09.2023.
//

import UIKit

protocol AppEpisodeListViewModelDelegate: AnyObject {
    func didLoadInitialEpisode()
    func didSelectEpisode(_ episode: AppEpisode)
    func didLoadMoreEpisodes(with newIndexPath:[IndexPath])
}
///  View Model to handle character list view logic
final class AppEpisodeListViewViewModel:NSObject {
    
    public weak var delegate: AppEpisodeListViewModelDelegate?
    
    private var isLoadingMoreEpisodes = false
    
    private let borderColors: [UIColor] = [
        .systemYellow,
        .systemGreen,
        .systemCyan,
        .systemBlue,
        .yellow,
        .orange,
        .systemOrange,
        UIColor(red: 0.09, green: 0.42, blue: 0.53, alpha: 1.00),
        UIColor(red: 0.15, green: 0.62, blue: 1.00, alpha: 1.00),
        UIColor(red: 0.84, green: 1.00, blue: 0.89, alpha: 1.00)
        
    ]
    
    var episodes: [AppEpisode] = [] {
        didSet {
//            print("Creating viewModels!")
            for episode in episodes {
                let viewModel = AppCharacterEpisodeCollectionViewCellViewModel(
                    episodeDataUrl: URL(string: episode.url),
                    borderColor: borderColors.randomElement() ?? .systemTeal
                    
                )
//               tekrar eklenmesinin önüne geçmek için
                if !cellViewModels.contains(viewModel) {
                    
                    cellViewModels.append(viewModel)
                    
                }
            }
        }
    }
    
    private var cellViewModels: [AppCharacterEpisodeCollectionViewCellViewModel] = []
    
    private var apiInfo: AppGetAllEpisodesResponse.Info? = nil
    
    /// Fetch initial set of episode (20 items)
    public func fetchEpisodes(){
        AppService.shared.execute(.listEpisodesRequests, expecting: AppGetAllEpisodesResponse.self) { [weak self] result in
            switch result {
            case .success(let responceModel):
                let results = responceModel.results
                let info = responceModel.info
                self?.episodes = results
                self?.apiInfo = info
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialEpisode()   // it will trigger update view so main thread
                }
               
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    /// Paginate if additional characters are needed
    public func fetchAdditionalEpisodes(url:URL){
        // ensure it is false, fetch new characters
        guard !isLoadingMoreEpisodes else{
            return
        }

        isLoadingMoreEpisodes = true
        
        guard let request = AppRequest(url: url) else {
            isLoadingMoreEpisodes = false
            print("Failed to create a request")
            return
        }
        
        AppService.shared.execute(request, expecting: AppGetAllEpisodesResponse.self) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let responseModel):
//                print("pre-update:\(strongSelf.cellViewModels.count)")
                
                let moreResults = responseModel.results
                let info = responseModel.info
                strongSelf.apiInfo = info
             
                let originalCount = strongSelf.episodes.count
                let newCount  = moreResults.count
                let totalCount = originalCount + newCount
                let startingIndex = totalCount - newCount
                
                let indexPathsToAdd: [IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap {
                    return IndexPath(row: $0, section: 0)
                }

                strongSelf.episodes.append(contentsOf: moreResults)
                
                
                DispatchQueue.main.async {

                    strongSelf.delegate?.didLoadMoreEpisodes(with: indexPathsToAdd)
                    strongSelf.isLoadingMoreEpisodes = false

                }

            case .failure(let failure):
                print(String(describing: failure))
                strongSelf.isLoadingMoreEpisodes = false
            }
        }

    }
    
    private var shouldLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
    
    
}
// MARK: - CollectionView datasource

extension AppEpisodeListViewViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppCharacterEpisodeCollectionViewCell.cellIdentifier, for: indexPath) as? AppCharacterEpisodeCollectionViewCell else {
            fatalError("Unsupported Cell")
        }
        let viewModel = cellViewModels[indexPath.row]
        
        cell.configure(viewModel: viewModel)
        return cell
    }
 
}
// MARK: - Collectionview delegate

extension AppEpisodeListViewViewModel:UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        let width = bounds.width - 30
        return CGSize(
            width: width,
            height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let episode = episodes[indexPath.row]
        delegate?.didSelectEpisode(episode)
        
    }
}

// MARK: - ScrollView
extension AppEpisodeListViewViewModel: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard shouldLoadMoreIndicator,
              !isLoadingMoreEpisodes,
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
                self?.fetchAdditionalEpisodes(url:url)
            }
            tmr.invalidate()
        }
        
        
    }
}

// MARK: - CollectionView Footer
/// to install new chars, adjusting a footer
extension AppEpisodeListViewViewModel {
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



