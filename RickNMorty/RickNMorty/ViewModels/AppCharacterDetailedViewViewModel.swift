//
//  AppCharacterViewModel.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 7.07.2023.
//

import Foundation

final class AppCharacterDetailedViewViewModel{
    
    private let character: AppCharacter
    
    init(character: AppCharacter) {
        self.character = character
    }
    
    public var requestUrl: URL? {
        return URL(string: character.url)
    }
    public var title: String {
        character.name.uppercased()
    }
    // bunu komple fetchlemeye gerek yok
//    public func fetchCharacterData(){
////        print(character.url)
//        guard let url = requestUrl,
//              let request = AppRequest(url: url) else {
//            print("Failed to create detailed character URL")
//            return
//        }
//        AppService.shared.execute(request, expecting: AppCharacter.self) { result in
//            switch result {
//            case.success(let success):
//                print(String(describing: success))
//            case.failure(let failure):
//                print(String(describing: failure))
//            }
//        }
//    }
    
}
