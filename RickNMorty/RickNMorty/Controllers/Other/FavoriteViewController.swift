//
//  FavoriteViewController.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 6.02.2025.
//

import UIKit

final class FavoriteViewController: UIViewController {
    
    private let favoriteView = FavoriteView()
    
    private var deleteBarButton: UIBarButtonItem?
    
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
        
        addDeleteButton()
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
extension FavoriteViewController{
    private func addDeleteButton(){
        deleteBarButton = UIBarButtonItem(image: UIImage(systemName: Constants.delete), style: .plain, target: self, action: #selector(deleteBarButtonTapped))
        navigationItem.rightBarButtonItem = deleteBarButton
    }
    
    @objc private func deleteBarButtonTapped(){
//        print("delete button tapped")
//        favoriteView.deleteButtonTapped()
        actionsForDeleteButton()
    }
    private func actionsForDeleteButton() {
       
        let isDeletingWanted = favoriteView.viewModel.isDeleteButtonTapped
        favoriteView.deleteButtonTapped()
        
        //true
        if !isDeletingWanted {// true-Delete istenmiyor, detaylı karakter seçimi yapılabilir
            favoriteView.viewModel.isDeleteButtonTapped = true
            self.deleteBarButton?.image = UIImage(systemName: Constants.deleteSelected)

        } else {// false-delete isteniyorsa, detaylı karaktere geçiş engellenir

            favoriteView.viewModel.isDeleteButtonTapped = false
            self.deleteBarButton?.image = UIImage(systemName: Constants.delete)
        }
    }
    func callAllert(){
        
        
    }
}
extension FavoriteViewController: FavoritesViewDelegate {
    // delete alert
    func deleteFavoritedListView(_ characterListView: FavoriteView, didDeleteCharacter character: AppCharacter) {
        
        let alert = UIAlertController(title: "Deletion of this \(character.type)", message: "Really want to delete \(character.name)?", preferredStyle: UIAlertController.Style.alert)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { _ in
            self.favoriteView.viewModel.deleteFavorite(character: character)
                }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { _ in 
            return
                }
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    func favoritedDetailedListView(_ characterListView: FavoriteView, didSelectCharacter character: AppCharacter) {
        // open a detailed controller for that character
        let viewModel = AppCharacterDetailedViewViewModel(character: character)
        let detailedVC = AppCharacterDetailedViewController(viewModel: viewModel)
        
        detailedVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailedVC, animated: true)  // charVC is a rootVC with navC, so navC will push
    }
}
