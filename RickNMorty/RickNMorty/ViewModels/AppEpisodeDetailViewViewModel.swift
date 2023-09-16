//
//  ppEpisodeDetailViewViewModel.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 13.09.2023.
//

import Foundation

final class AppEpisodeDetailViewViewModel {
    
    private let endpointUrl : URL?
    
    // MARK: - init
    
    init(endpointUrl : URL?){
        self.endpointUrl = endpointUrl
        fetchEpisodeData()
    }
    /// Fetch episode model
    private func fetchEpisodeData(){
        guard let url = endpointUrl, let request = AppRequest(url: url) else {
            return
        }
        
        AppService.shared.execute(request, expecting: AppEpisode.self) { [weak self] result in
            switch result {
            case .success(let model):
//                print(String(describing: model))
                self?.fetchRelatedCharacters(episode: model)
            case .failure:
                break
            }
        }
        
    }
    
    private func fetchRelatedCharacters(episode: AppEpisode){
        let characterURLS: [URL] = episode.characters.compactMap({
            return URL(string: $0)
        })
        
        let requests: [AppRequest] = characterURLS.compactMap({
            return AppRequest(url: $0)
        })
        
        let group = DispatchGroup()
        var characters: [AppCharacter] = []
        
        for request in requests {   //+20
            group.enter()
            
            AppService.shared.execute(request, expecting: AppCharacter.self) { result in
                defer {
                    group.leave()   //-20
                }
                switch result {
                case .success(let model):
                    characters.append(model)
                case .failure:
                        break
                }
            }
        }
    }
}
