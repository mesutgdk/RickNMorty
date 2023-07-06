//
//  CharacterViewController.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 26.06.2023.
//

import UIKit

final class CharacterViewController: UIViewController {

    private let characterListView = AppCharacterListView()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
    }
}
extension CharacterViewController {
    private func setup() {
        view.backgroundColor = .systemBackground
        title = "Character"
        
        
    }
    
    private func layout() {
        view.addSubview(characterListView)
        // characterListView
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            characterListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
