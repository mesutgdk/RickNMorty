//
//  Character.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 26.06.2023.
//

import Foundation

struct AppCharacter: Codable {
    let id: Int
    let name: String
    let status: AppCharacterStatus
    let species: String
    let type: String
    let gender: AppCharacterGender
    let origin: AppOrigin
    let location: AppCharLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
}
 
