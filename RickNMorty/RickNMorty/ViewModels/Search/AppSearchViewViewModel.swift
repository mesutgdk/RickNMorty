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
    
    private var optionMapUpdateBlock: (((AppSearchInputViewViewModel.DynamicOption, String)) -> Void)?
    
    private var optionMap: [AppSearchInputViewViewModel.DynamicOption : String] = [:]
    
    // MARK: - Init

    init(config: AppSearchViewController.Config) {
        self.config = config
    }
    
    // MARK: - Public
    
    public func set(value: String, for option: AppSearchInputViewViewModel.DynamicOption){
        optionMap[option] = value
        let tuple = (option, value)
        optionMapUpdateBlock?(tuple)
    }
    
    public func registerOptionChangeBlock(_ block: @escaping ((AppSearchInputViewViewModel.DynamicOption, String)) -> Void){
        self.optionMapUpdateBlock = block
    }

}
