//
//  AppCharacterViewCellViewModel.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 6.07.2023.
//

import Foundation

final class AppCharacterCollectionViewCellViewModel {
    
    public let characterName: String
    private let characterStatus: AppCharacterStatus
    private let characterImageUrl: URL?
    
    // MARK: - init

    init(
    characterName: String,
    characterStatus: AppCharacterStatus,
    characterImageUrl: URL?
    ) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageUrl = characterImageUrl
    }
    
    public var characterStatusText: String {
        return characterStatus.rawValue
    }
    
    public func fetchImage(completion: @escaping (Result<Data,Error>) -> Void) {
        
        // todo: Abstract to Image Manager
        guard let url = characterImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
           
            completion(.success(data))
        }
        task.resume()
    }
}
