//
//  AppSearchResultViewModel.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 11.10.2023.
//

import Foundation

struct AppSearchResultViewModel{
    let result: AppSearchResultType
    let next: String?
    
    public private(set) var isLoadingMoreResults = false
    
    public var shouldLoadMoreIndicator: Bool {
        return next != nil
    }
    
}

enum AppSearchResultType{
    case characters([AppCharacterCollectionViewCellViewModel])
    case episodes([AppCharacterEpisodeCollectionViewCellViewModel])
    case locations([AppLocationTableViewCellViewModel])
}
