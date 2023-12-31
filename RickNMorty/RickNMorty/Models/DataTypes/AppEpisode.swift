//
//  Episode.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 26.06.2023.
//

import UIKit

struct AppEpisode: Codable, AppEpisodeDataRender {
    
    let id: Int
    let name: String
    let air_date: String
    let episode: String
    let characters: [String]
    let url: String
    let created: String
}
