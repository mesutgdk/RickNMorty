//
//  FavoriteView.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 5.02.2025.
//

import UIKit

protocol FavoritesViewDelegate: AnyObject {
    func favoritedDetailedListView(_ characterListView: FavoriteView, didSelectCharacter character: AppCharacter)

}

final class FavoriteView: UIView {
    public weak var delegate: FavoritesViewDelegate?

    let viewModel = FavoriteViewViewModel()
    
    private let spinner : UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    } ()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.register(AppCharacterCollectionListViewCell.self, forCellWithReuseIdentifier: AppCharacterCollectionListViewCell.cellIdentifier)
       
        return collectionView
    } ()
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        translatesAutoresizingMaskIntoConstraints = false
        
        spinner.startAnimating()
        
        viewModel.delegate = self
        viewModel.retrieveFavoritedCharacters()
        
        setupCollectionView()
    }
    
    private func layout(){
        addSubviews(collectionView,spinner)

        
        // spinner
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        
        // collectionView
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor,constant: 10),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor, constant: -10),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupCollectionView(){
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
    }
    
    
    func deleteButtonTapped(){
        if viewModel.isDeleteButtonTapped {
            collectionView.allowsMultipleSelection = true
            collectionView.alpha = 1
        } else{
            collectionView.allowsMultipleSelection = false
            collectionView.alpha = 0.5
        }
    }
}

extension FavoriteView: FavoriteViewModelDelegate {
    func didSelectCharacter(_ character: AppCharacter) {
        delegate?.favoritedDetailedListView(self, didSelectCharacter: character)
//        print(character.name)
    }
    
    func didLoadInitialCharacter() {
        spinner.stopAnimating()
        collectionView.isHidden = false
        collectionView.reloadData()  // initial fetch characters
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
        }
    }

}

