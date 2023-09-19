//
//  ppEpisodeDetailViewViewModel.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 13.09.2023.
//

import UIKit

protocol AppEpisodeDetailViewViewModelDelegate: AnyObject {
    func didFetchEpisodeDetail()
}

final class AppEpisodeDetailViewViewModel {
    
    private let endpointUrl : URL?
    
    private var dataTuple: (episode: AppEpisode,characters: [AppCharacter])? {
        didSet {
            createCellViewModels()
            delegate?.didFetchEpisodeDetail()
        }
    }

    public weak var delegate: AppEpisodeDetailViewViewModelDelegate?
    
    enum SectionType{
        case information(viewModes: [AppEpisodeInfoCollectionViewCellViewModel])
        case character(viewModel: [AppCharacterCollectionViewCellViewModel])
    }
    
    public private(set) var cellViewModels: [SectionType] = [] // only for reading, no writing
    
    public let cellBorderColor : UIColor = .secondaryLabel
    
    
    // MARK: - init
    
    init(endpointUrl : URL?){
        self.endpointUrl = endpointUrl
    }
    
    // MARK: - Public Func
    
    // to take the character
    public func character(at index: Int) -> AppCharacter? {
        guard let dataTuple = dataTuple else {
            return nil
        } 
        return dataTuple.characters[index]
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
    
    // MARK: - Private
    private func createCellViewModels() {
        guard let dataTuple = dataTuple else {
            return
        }
        let episode = dataTuple.episode //
        let characters = dataTuple.characters
        
        
        
        var createdString = episode.created
        if let date = AppCharacterInfoCollectionViewCellViewModel.dateFormatter.date(from: episode.created) {
            createdString = AppCharacterInfoCollectionViewCellViewModel.shortDateFormatter.string(from: date)
        }
        
        cellViewModels = [
            .information(viewModes: [
                .init(title: "Episode Name", value: episode.name),
                .init(title: "Air Date", value: episode.air_date),
                .init(title: "Episode", value: episode.episode),
                .init(title: "Created", value: createdString)
            ]),
            .character(viewModel: characters.compactMap({character in
                return AppCharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image))
            }))
        ]
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
