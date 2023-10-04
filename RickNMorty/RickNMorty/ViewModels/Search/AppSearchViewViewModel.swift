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
            Send API Call
            Notify view of result, no result, or error
         */
    public func executeSearch(){
        
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
