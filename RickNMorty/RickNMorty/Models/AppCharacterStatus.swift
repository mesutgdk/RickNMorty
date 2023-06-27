//
//  CharacterStatus.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 27.06.2023.
//

import Foundation

enum AppCharacterStatus: String, Codable {
    // 'Alive, 'Dead', or 'unknown'
    case alive = "Alive"
    case dead = "dead"
    case unknown = "unkown"
    
}
