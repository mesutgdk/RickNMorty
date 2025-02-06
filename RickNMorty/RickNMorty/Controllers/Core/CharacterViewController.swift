//
//  CharacterViewController.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 26.06.2023.
//

import UIKit

final class CharacterViewController: UIViewController {

    private let characterListView = AppCharacterListView()
    
    private var switchLayoutBarButtonItem: UIBarButtonItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
        addSearchButton()
        addListGridAndFavoriteBarButtons()
    }

    private func setup() {
        view.addSubview(characterListView)

        view.backgroundColor = .systemBackground
        title = "Character"
        
        characterListView.delegate = self
    }
    
    private func layout() {
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

// MARK: - Search Button
extension CharacterViewController {
    private func addSearchButton(){
        let searchBarButton = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
        navigationItem.rightBarButtonItem = searchBarButton
    }
    
    @objc private func searchButtonTapped(){
        let vc = AppSearchViewController(config: AppSearchViewController.Config(type: .character))
        vc.navigationItem.largeTitleDisplayMode = .never
//        present(vc, animated: true)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func favoritesButtonTapped(){
        let favoriteVC = FavoriteViewController()
        favoriteVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(favoriteVC, animated: true)
    }
}

// MARK: - Grid-List Change Button - Favorites Button
extension CharacterViewController {
    private func addListGridAndFavoriteBarButtons(){
        switchLayoutBarButtonItem = UIBarButtonItem(image: Constants.gridLayoutImage, style: .plain, target: self, action: #selector(listGridButtonTapped))
        let favoritedBarButton = UIBarButtonItem(image: UIImage(systemName: Constants.favoriteImage), style: .plain, target: self, action: #selector(favoritesButtonTapped))
        navigationItem.leftBarButtonItems = [ switchLayoutBarButtonItem!, favoritedBarButton]
    }
    
    @objc private func listGridButtonTapped(){
        fetchLayoutType()
    }
    private func fetchLayoutType() {
       
        let isListLayout = characterListView.viewModel.isList
        
        if isListLayout {
            // List görünümüne geçiş kodunu buraya ekleyin
            characterListView.viewModel.isList = false
            DispatchQueue.main.async {
                self.switchLayoutBarButtonItem?.image = Constants.listLayoutImage
                self.characterListView.collectionView.reloadData()
            }
            
        } else {
            // Grid görünümüne geçiş kodunu buraya ekleyin
            characterListView.viewModel.isList = true
            DispatchQueue.main.async {
                self.switchLayoutBarButtonItem?.image = Constants.gridLayoutImage
                self.characterListView.collectionView.reloadData()
            }
            
        }
    }
    
}


