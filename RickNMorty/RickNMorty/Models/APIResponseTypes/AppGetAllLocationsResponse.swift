//
//  AppGetAllLocationsResponse.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 22.09.2023.
//

import Foundation
struct AppGetAllLocationsResponse: Codable {
    struct Info: Codable {
        
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [AppLocation]
}
