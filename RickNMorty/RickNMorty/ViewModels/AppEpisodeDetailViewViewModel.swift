//
//  ppEpisodeDetailViewViewModel.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 13.09.2023.
//

import Foundation

final class AppEpisodeDetailViewViewModel {
    
    private let endpointUrl : URL?
    
    init(endpointUrl : URL?){
        self.endpointUrl = endpointUrl
        fetchEpisodeData()
    }
    private func fetchEpisodeData(){
        guard let url = endpointUrl, let request = AppRequest(url: url) else {
            return
        }
        
        AppService.shared.execute(request, expecting: AppEpisode.self) { result in
            switch result {
            case .success(let success):
                print(String(describing: success))
            case .failure:
                break
            }
        }
//        guard let url = endpointUrl, let request = AppRequest(url: url) else {return}

    }
}
