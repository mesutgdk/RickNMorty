//
//  AppCharacterViewCellViewModel.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 6.07.2023.
//

import UIKit

final class AppCharacterCollectionViewCellViewModel:Hashable {
  
    
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
        return characterStatus.text
    }
    public var characterStatusTextColor: UIColor {
        return characterStatus.textColor
    }
    
    
    public func fetchImage(completion: @escaping (Result<Data,Error>) -> Void) {
        
        // todo: Abstract to Image Manager
        guard let url = characterImageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
//        print(url)
//        let request = URLRequest(url: url)
        AppImageLoader.shared.downloadImage(url, completion: completion) // assign the downloadtask to a manager/loader
    }
    // MARK: - Hashable
    
    static func == (lhs: AppCharacterCollectionViewCellViewModel, rhs: AppCharacterCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterStatus)
        hasher.combine(characterImageUrl)
    }
    
}
