//
//  AppCharacterInfoCollectionViewCellViewModel.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 3.08.2023.
//

import Foundation

final class AppCharacterInfoCollectionViewCellViewModel {
    public let value: String
    public let title: String
    
    init(value: String,title: String) {
        self.title = title
        self.value = value
    }
}
