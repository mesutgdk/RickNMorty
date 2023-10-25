//
//  AppSearchResultViewModel.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 11.10.2023.
//

import Foundation

final class AppSearchResultViewModel{
    public private(set) var results: AppSearchResultType
    private var next: String?
    
    init(result: AppSearchResultType, next: String?) {
        self.results = result
        self.next = next
//        print(next)
    }
    
    public private(set) var isLoadingMoreResults = false
    
    public var shouldLoadMoreIndicator: Bool {
        return next != nil
    }
    public func fetchAdditionalLocationPage(completion: @escaping ([AppLocationTableViewCellViewModel]) -> Void){
        // ensure it is false, fetch new characters
        guard !isLoadingMoreResults else{
            return
        }
        guard let nextUrlString = next,
              let url = URL(string: nextUrlString) else {
            return
        }
        
        isLoadingMoreResults = true
        
        guard let request = AppRequest(url: url) else {
            isLoadingMoreResults = false
            print("Failed to create a request")
            return
        }
        
        AppService.shared.execute(request, expecting: AppGetAllLocationsResponse.self) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let responseModel):
//                print("pre-update:\(strongSelf.results)")
                
                let moreResults = responseModel.results
                let info = responseModel.info
                strongSelf.next = info.next // to capture new pagination url
//                print(info.next)

                let additionalLocations = moreResults.compactMap({
                    return AppLocationTableViewCellViewModel(location: $0)
                })
                var newResults: [AppLocationTableViewCellViewModel] = []
                switch strongSelf.results{
                case .locations(let existingResults):
                    newResults = existingResults + additionalLocations
                    strongSelf.results = .locations(newResults)
                    break
                case .characters, .episodes:
                    break
                }
                
                DispatchQueue.main.async {
                    strongSelf.isLoadingMoreResults = false
                    
                    // notify via callback
                    completion(newResults)
//                    strongSelf.finishPagination?()
                }

            case .failure(let failure):
                print(String(describing: failure))
                self?.isLoadingMoreResults = false
            }
        }

    }
    public func fetchAdditionalResults(completion: @escaping ([any Hashable]) -> Void){
        // ensure it is false, fetch new characters
        guard !isLoadingMoreResults else{
            return
        }
        guard let nextUrlString = next,
              let url = URL(string: nextUrlString) else {
            return
        }
        
        isLoadingMoreResults = true
        
        guard let request = AppRequest(url: url) else {
            isLoadingMoreResults = false
            print("Failed to create a request")
            return
        }
        
        
        switch results {
            // character request case
        case .characters(let existingResults):
            AppService.shared.execute(request, expecting: AppGetAllCharactersResponse.self) { [weak self] result in
                guard let strongSelf = self else {
                    return
                }
                switch result {
                case .success(let responseModel):
    //                print("pre-update:\(strongSelf.results)")
                    
                    let moreResults = responseModel.results
                    let info = responseModel.info
                    strongSelf.next = info.next // to capture new pagination url
                    //                print(info.next)
                    
                    let additionalResults = moreResults.compactMap({
                        return AppCharacterCollectionViewCellViewModel(characterName: $0.name,
                                                                       characterStatus: $0.status,
                                                                       characterImageUrl: URL(string: $0.image))
                    })
                    var newResults: [AppCharacterCollectionViewCellViewModel] = []
                    
                    newResults = existingResults + additionalResults
                    strongSelf.results = .characters(newResults)
                    
                    DispatchQueue.main.async {
                        strongSelf.isLoadingMoreResults = false
                        
                        // notify via callback
                        completion(newResults)
    //                    strongSelf.finishPagination?()
                    }

                case .failure(let failure):
                    print(String(describing: failure))
                    self?.isLoadingMoreResults = false
                }
            }
            // episode request case
        case .episodes(let existingResults):
            
            AppService.shared.execute(request, expecting: AppGetAllEpisodesResponse.self) { [weak self] result in
                guard let strongSelf = self else {
                    return
                }
                switch result {
                case .success(let responseModel):
    //                print("pre-update:\(strongSelf.results)")
                    
                    let moreResults = responseModel.results
                    let info = responseModel.info
                    strongSelf.next = info.next // to capture new pagination url
    //                print(info.next)

                    let additionalResults = moreResults.compactMap({
                        return AppCharacterEpisodeCollectionViewCellViewModel(episodeDataUrl: URL(string: $0.url))
                    })
                    var newResults: [AppCharacterEpisodeCollectionViewCellViewModel] = []
                    
                    newResults = existingResults + additionalResults
                    strongSelf.results = .episodes(newResults)
                    
                    DispatchQueue.main.async {
                        strongSelf.isLoadingMoreResults = false
                        
                        // notify via callback
                        completion(newResults)
    //                    strongSelf.finishPagination?()
                    }

                case .failure(let failure):
                    print(String(describing: failure))
                    self?.isLoadingMoreResults = false
                }
            }
            
            // location request case
        case .locations:
            //TableView Case
            break
        }
    }
}

enum AppSearchResultType{
    case characters([AppCharacterCollectionViewCellViewModel])
    case episodes([AppCharacterEpisodeCollectionViewCellViewModel])
    case locations([AppLocationTableViewCellViewModel])
}
