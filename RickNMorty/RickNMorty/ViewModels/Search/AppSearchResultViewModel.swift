//
//  AppSearchResultViewModel.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 11.10.2023.
//

import Foundation

enum AppSearchResultViewModel{
    case characters([AppCharacterCollectionViewCellViewModel])
    case episodes([AppCharacterEpisodeCollectionViewCellViewModel])
    case locations([AppLocationTableViewCellViewModel])
    
    
}
