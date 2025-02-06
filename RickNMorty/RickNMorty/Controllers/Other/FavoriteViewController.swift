//
//  FavoriteViewController.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 6.02.2025.
//

import UIKit

final class FavoriteViewController: UIViewController {
    
    private let favoriteView = FavoriteView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
    }

    private func setup() {
        view.addSubview(favoriteView)

        view.backgroundColor = .systemBackground
        title = "Favorites"
        
        favoriteView.delegate = self
    }
    
    private func layout() {
        // characterListView
        NSLayoutConstraint.activate([
            favoriteView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            favoriteView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            favoriteView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            favoriteView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
extension FavoriteViewController: FavoritesViewDelegate {
    func favoritedDetailedListView(_ characterListView: FavoriteView, didSelectCharacter character: AppCharacter) {
        // open a detailed controller for that character
        let viewModel = AppCharacterDetailedViewViewModel(character: character)
        let detailedVC = AppCharacterDetailedViewController(viewModel: viewModel)
        
        detailedVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailedVC, animated: true)  // charVC is a rootVC with navC, so navC will push
    }
}
