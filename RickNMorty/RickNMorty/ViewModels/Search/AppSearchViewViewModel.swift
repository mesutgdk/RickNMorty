//
//  AppSearchViewViewModel.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 27.09.2023.
//

import Foundation

/*
 Responsibilties
 - show search resurchs
 - show no result view
 - kick off API request
 */
final class AppSearchViewViewModel{
    
    let config : AppSearchViewController.Config
    
    private var searchText = ""
    
    private var optionMap: [AppSearchInputViewViewModel.DynamicOption : String] = [:]
    
    private var optionMapUpdateBlock: (((AppSearchInputViewViewModel.DynamicOption, String)) -> Void)?
    
    private var searchResultHandler: ((AppSearchResultViewModel) -> Void)?
    
    private var noResultsHandler: (() -> Void)?
    
    private var searchResultModel : Codable?
    // MARK: - Init
    
    init(config: AppSearchViewController.Config) {
        self.config = config
    }
    
    // MARK: - Public
    
    public func registerSearchResultHandler(_ block: @escaping (AppSearchResultViewModel) -> Void){
        self.searchResultHandler = block
    }
    
    public func registerNoResultsHandler(_ block: @escaping () -> Void){
        self.noResultsHandler = block
    }
    
    /*  Create request based on filters
     https://rickandmortyapi.com/api/character/
     ?name= += "rick"
     &status=alive
     Send API Call
     Notify view of result, no result, or error
     */
    public func executeSearch(){
        // boş olarak arama yapamamak için
        guard !searchText.trimmingCharacters(in: .whitespaces).isEmpty else {
            return
        }
        
//        print("search text: \(searchText)")
        var querryParameter: [URLQueryItem] = []
        
        switch config.type {
        case .character, .episode:
            
            querryParameter.append(URLQueryItem(name: "name", value: searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))) // aramada arada boşluk konuluyorsa hatadan kurtulma yolu
        case .location:
            querryParameter.append(URLQueryItem(name: "name", value: searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)))
        }
        // Add options
        querryParameter.append(contentsOf: optionMap.enumerated().compactMap({
            _,element in
            let key :AppSearchInputViewViewModel.DynamicOption = element.key
            let value : String = element.value
            return URLQueryItem(name: key.querryArgument, value: value)
        }))
        
        // Create request
        let request = AppRequest(endPoint: config.type.endpoint,
                                 queryParameters: querryParameter)
        
        //        print(request.url?.absoluteString)
        
        // search yaparken gruba göre endpoint oluşturabilmek için
        switch config.type.endpoint {
        case .character:
            makeSearchAPICall(AppGetAllCharactersResponse.self, request: request)
        case .location:
            makeSearchAPICall(AppGetAllLocationsResponse.self, request: request)
        case .episode:
            makeSearchAPICall(AppGetAllEpisodesResponse.self, request: request)
        }
        
    }
    private func makeSearchAPICall<T:Codable>(_ type: T.Type, request: AppRequest){
        
        AppService.shared.execute(request, expecting: type) { [weak self] result in
            
//            notify view of results, no results, or error
            switch result {
            case .success(let model):
                //Episodes-Characters-> CollectionView / Localition -> TableView
                
                self?.processSearchResults(model: model)
                
//                print("search results are: \(model)")
                
            case .failure(let error):
                print(String(describing: error))
                
                self?.handleNoResult()
            }
        }
    }
    
    private func processSearchResults(model: Codable){
        var resultsVM: AppSearchResultViewModel?
        
        if let characterResults = model as? AppGetAllCharactersResponse{
//            print("Results: \(characterResults.results)")
            resultsVM = .characters(characterResults.results.compactMap({
                return AppCharacterCollectionViewCellViewModel(
                    characterName: $0.name,
                    characterStatus: $0.status,
                    characterImageUrl: URL(string: $0.url))
            }))
        }
        else if let episodeResults = model as? AppGetAllEpisodesResponse{
//            print("Results: \(episodeResults.results)")
            resultsVM = .episodes(episodeResults.results.compactMap({
                return AppCharacterEpisodeCollectionViewCellViewModel(episodeDataUrl: URL(string: $0.url))
            }))
        }
        else if let locationResults = model as? AppGetAllLocationsResponse{
//            print("Results: \(locationResults.results)")
            resultsVM = .locations(locationResults.results.compactMap({
                return AppLocationTableViewCellViewModel(location: $0)
            }))
        }
        
        if let results = resultsVM {
            self.searchResultModel = model // to select the row after searching view
            self.searchResultHandler?(results)
            
        } else {
            // fallback error
            self.handleNoResult()
        }
    }
    
    private func handleNoResult(){
//        print("no Result")
        noResultsHandler?()
    }
    
    public func set(query text: String){
        self.searchText = text
    }
    
    public func set(value: String, for option: AppSearchInputViewViewModel.DynamicOption){
        optionMap[option] = value
        let tuple = (option, value)
        optionMapUpdateBlock?(tuple)
    }
    
    public func registerOptionChangeBlock(_ block: @escaping ((AppSearchInputViewViewModel.DynamicOption, String)) -> Void){
        self.optionMapUpdateBlock = block
    }
    
    public func locationSearchResult(at index: Int) -> AppLocation? {
        guard let searchModel = searchResultModel as? AppGetAllLocationsResponse else {
            return nil
        }
        return searchModel.results[index]
    }
}
