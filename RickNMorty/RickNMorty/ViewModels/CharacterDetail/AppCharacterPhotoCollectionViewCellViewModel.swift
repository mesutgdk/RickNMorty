//
//  AppCharacterPhotoCollectionViewCellViewModel.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 3.08.2023.
//

import Foundation

final class AppCharacterPhotoCollectionViewCellViewModel {
    private let imageUrl: URL?
    
    init(imageUrl:URL?) {
        self.imageUrl = imageUrl
    }
    
    public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let imageUrl = imageUrl else {
            completion(.failure(URLError(.badURL)))
            return
        }
        AppImageLoader.shared.downloadImage(imageUrl, completion: completion)
    }
}
