//
//  AppCharacterViewModel.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 7.07.2023.
//

import Foundation

final class AppCharacterViewViewModel{
    
    private let character: AppCharacters
    
    init(character: AppCharacters) {
        self.character = character
    }
    
    public var title: String {
        character.name.uppercased()
    }
}
