//
//  ppEpisodeDetailViewViewModel.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 13.09.2023.
//

import Foundation

protocol AppEpisodeDetailViewViewModelDelegate: AnyObject {
    func didFetchEpisodeDetail()
}

final class AppEpisodeDetailViewViewModel {
    
    private let endpointUrl : URL?
    
    public weak var delegate: AppEpisodeDetailViewViewModelDelegate?
    
    private var dataTuple: (AppEpisode,[AppCharacter])? {
        didSet {
            delegate?.didFetchEpisodeDetail()
        }
    }
    
    // MARK: - init
    
    init(endpointUrl : URL?){
        self.endpointUrl = endpointUrl

    }
    /// Fetch episode model
    public func fetchEpisodeData(){
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
        group.notify(queue: .main) {
            self.dataTuple = (
                episode: episode,
                characters: characters
            )
        }
    }
}
