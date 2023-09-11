//
//  AppCharacterEpisodeCollectionViewCell.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 3.08.2023.
//

import Foundation

final class AppCharacterEpisodeCollectionViewCellViewModel{ // need networking
    private let episodeDataUrl: URL?
    
    private var isFetching = false
    
    // MARK: - Init

    init(episodeDataUrl: URL?) {
        self.episodeDataUrl = episodeDataUrl
    }
    
    
    public func fetchEpisode(){
        guard !isFetching else { return }
        guard let url = episodeDataUrl, let request = AppRequest(url: url) else {
            print("i returned from guard request")
            return}
        
        isFetching = true
        
        AppService.shared.execute(request, expecting: AppEpisode.self) { result in
            switch result {
            case .success(let success):
                print(String(describing: success.id))
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
//        print("created")
    }
}
