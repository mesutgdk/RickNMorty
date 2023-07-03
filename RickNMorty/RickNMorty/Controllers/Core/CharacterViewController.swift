//
//  CharacterViewController.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 26.06.2023.
//

import UIKit

final class CharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        title = "Character"

        AppService.shared.execute(.listCharacterRequests, expecting: AppGetAllCharactersResponse.self) { result in
            switch result {
            case .success(let model):
                print(String(describing: model))
            case .failure(let error):
                print(String(describing: error)) 
            }
        }

      
    }
}
