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
}
