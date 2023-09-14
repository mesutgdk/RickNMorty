//
//  AppCharacterEpisodeCollectionViewCell.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 3.08.2023.
//

import Foundation

protocol AppEpisodeDataRender {
    var name: String { get }
    var air_date: String { get }
    var episode: String { get }
}

final class AppCharacterEpisodeCollectionViewCellViewModel: Hashable, Equatable{
  
    // need networking
    private let episodeDataUrl: URL?
    
    private var isFetching = false
    
    private var dataBlock: ((AppEpisodeDataRender) -> Void)?
    
    private var episode: AppEpisode? {
        didSet {
            guard let model = episode else {return}
            dataBlock?(model)
        }
    }
    
    // MARK: - Init

    init(episodeDataUrl: URL?) {
        self.episodeDataUrl = episodeDataUrl
    }
    
    // MARK: - Public
    
    public func registerForData(_ block: @escaping (AppEpisodeDataRender) -> Void) {
        self.dataBlock = block
    }
    
    public func fetchEpisode(){
        guard !isFetching else {
            if let model = episode {
                dataBlock?(model)
            }
            return
        }
        guard let url = episodeDataUrl, let request = AppRequest(url: url) else {
            print("i returned from guard request")
            return}
        
        isFetching = true
        
        AppService.shared.execute(request, expecting: AppEpisode.self) { [weak self] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.episode = model
                }
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
//        print("created")
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.episodeDataUrl?.absoluteString ?? "")
    }
    static func == (lhs: AppCharacterEpisodeCollectionViewCellViewModel, rhs: AppCharacterEpisodeCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
