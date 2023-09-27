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
    
    init(config: AppSearchViewController.Config) {
        self.config = config
    }
}
