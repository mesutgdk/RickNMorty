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
    
    // MARK: - Init

    init(config: AppSearchViewController.Config) {
        self.config = config
    }
    
    // MARK: - Public
        /*  Create request based on filters
         https://rickandmortyapi.com/api/character/
         ?name= += "rick"
         &status=alive
            Send API Call
            Notify view of result, no result, or error
         */
    public func executeSearch(){
        switch config.type {
        case .character:
            searchText = "Rich"
            var urlString = "https://rickandmortyapi.com/api/character/"
            urlString += "?name=\(searchText)"
            
            for (option, value) in optionMap {
                urlString += "&\(option.querryArgument)=\(value)"
            }
            
            guard let url = URL(string: urlString) else {
                return
            }
            
            guard let request = AppRequest(url: url) else {
                return
            }
            
            AppService.shared.execute(request, expecting: AppGetAllCharactersResponse.self) { result in
                switch result {
                case .success(let model):
                    print("search results are: \(model.results.count)")
                case .failure(let error):
                    fatalError("cant take request")
                }
            }
        case .episode:
            break
        case .location:
            break
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
