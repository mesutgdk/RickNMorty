//
//  CharacterListViewViewModel.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 4.07.2023.
//

import Foundation

struct CharacterListViewViewModel {
    
    func fetchCharacters(){
        AppService.shared.execute(.listCharacterRequests, expecting: AppGetAllCharactersResponse.self) { result in
            switch result {
            case .success(let model):
                print("Total: "+String(model.info.count))
                print("Page result count: "+String(model.results.count))
            case .failure(let error):
                print(String(describing: error))
            }
        }

    }
}
