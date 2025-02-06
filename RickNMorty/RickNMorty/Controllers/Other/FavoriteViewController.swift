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
        
//        characterListView.delegate = self
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
