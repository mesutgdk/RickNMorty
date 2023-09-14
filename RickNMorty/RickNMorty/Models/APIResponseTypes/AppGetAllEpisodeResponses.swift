//
//  AppGetAllEpisodeResponses.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 14.09.2023.
//

import Foundation

struct AppGetAllEpisodesResponse: Codable {
    struct Info: Codable {
        
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }
    
    let info: Info
    let results: [AppEpisode]
}

