//
//  AppCharacterEpisodeCollectionViewCell.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 3.08.2023.
//

import Foundation

final class AppCharacterEpisodeCollectionViewCellViewModel{ // need networking
    private let episodeDataUrl: URL?
    
    init(episodeDataUrl: URL?) {
        self.episodeDataUrl = episodeDataUrl
    }
    
    public func fetchEpisode(){
        print(episodeDataUrl)
        guard let url = episodeDataUrl, let appRequest = AppRequest(url: url) else {
            print("i returned from guard let apprequest")
            return}
        
        print("created")
    }
}
