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
        
        characterListView.delegate = self
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
// MARK: - AppCharacterListViewDelegate

extension CharacterViewController: AppCharacterViewDelegate {
    func appDetailedCharacterListView(_ characterListView: AppCharacterListView, didSelectCharacter character: AppCharacter) {
        // open a detailed controller for that character
        let viewModel = AppCharacterDetailedViewViewModel(character: character)
        let detailedVC = AppCharacterDetailedViewController(viewModel: viewModel)
        
        detailedVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailedVC, animated: true)  // charVC is a rootVC with navC, so navC will push
    }
    
    
}
