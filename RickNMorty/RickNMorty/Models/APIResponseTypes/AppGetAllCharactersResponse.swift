//
//  AppGetAllCharactersResponse.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 3.07.2023.
//

import Foundation

struct AppGetAllCharactersResponse: Codable {
    struct Info: Codable {
        
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [AppCharacters]
}
