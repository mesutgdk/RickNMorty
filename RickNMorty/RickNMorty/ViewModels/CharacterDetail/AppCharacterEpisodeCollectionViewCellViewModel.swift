//
//  AppCharacterEpisodeCollectionViewCell.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 3.08.2023.
//

import Foundation

final class AppCharacterEpisodeCollectionViewCellViewModel{ // need networking
    private let episodeUrl: URL?
    
    init(let episodeUrl: URL?) {
        self.episodeUrl = episodeUrl
    }
}
