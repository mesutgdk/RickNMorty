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
    
    private var registerSearchResultHandler: (() -> Void)?
    // MARK: - Init

    init(config: AppSearchViewController.Config) {
        self.config = config
    }
    
    // MARK: - Public
    
    public func registerSearchResultHandler(_ block: @escaping () -> Void){
        self.registerSearchResultHandler = block
    }
        /*  Create request based on filters
         https://rickandmortyapi.com/api/character/
         ?name= += "rick"
         &status=alive
            Send API Call
            Notify view of result, no result, or error
         */
    public func executeSearch(){
        print("search text: \(searchText)")
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
        
        print(request.url?.absoluteString)
        
        AppService.shared.execute(request, expecting: AppGetAllCharactersResponse.self) { result in
            switch result {
            case .success(let model):
                //Episodes-Characters-> CollectionView / Localition -> TableView
                print("search results are: \(model.results.count)")
            case .failure(let error):
                print("no Result")
                
            }
        }
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

}
