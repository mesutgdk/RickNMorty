//
//  AppLocationDetailViewViewModel.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 25.09.2023.
//

import UIKit

protocol AppLocationDetailViewViewModelDelegate: AnyObject {
    func didFetchLocationDetail()
}

final class AppLocationDetailViewViewModel {
    
    private let endpointUrl : URL?
    
    private var dataTuple: (location: AppLocation, characters: [AppCharacter])? {
        didSet {
            createCellViewModels()
            delegate?.didFetchLocationDetail()
        }
    }

    public weak var delegate: AppLocationDetailViewViewModelDelegate?
    
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

    /// Fetch location model
    public func fetchLocationData(){
        guard let url = endpointUrl,
              let request = AppRequest(url: url) else {
            return
        }
        
        AppService.shared.execute(request, expecting: AppLocation.self) { [weak self] result in
            switch result {
            case .success(let model):
//                print(String(describing: model))
                self?.fetchRelatedCharacters(location: model)
            case .failure:
                break
            }
        }
        
    }
    // MARK: - Private
    private func fetchRelatedCharacters(location: AppLocation){
        let characterURLS: [URL] = location.residents.compactMap({
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
                location: location,
                characters: characters
            )
        }
    }
    

    private func createCellViewModels() {
        guard let dataTuple = dataTuple else {
            return
        }
        let location = dataTuple.location //
        let characters = dataTuple.characters
        
        
        
        var createdString = location.created
        if let date = AppCharacterInfoCollectionViewCellViewModel.dateFormatter.date(from: location.created) {
            createdString = AppCharacterInfoCollectionViewCellViewModel.shortDateFormatter.string(from: date)
        }
        
        cellViewModels = [
            .information(viewModes: [
                .init(title: "Location Name", value: location.name),
                .init(title: "Type", value: location.type),
                .init(title: "Dimension", value: location.dimension),
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

    
}

