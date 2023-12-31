//
//  CharacterListView.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 4.07.2023.
//

import UIKit

protocol AppCharacterViewDelegate: AnyObject {
    func appDetailedCharacterListView(_ characterListView: AppCharacterListView, didSelectCharacter character: AppCharacter)
}

/// View that handles showing list of characters, loader, etc.
final class AppCharacterListView: UIView {
    
    public weak var delegate: AppCharacterViewDelegate?

    let viewModel = AppCharacterListViewViewModel()
    
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
        collectionView.register(AppCharacterCollectionGridViewCell.self, forCellWithReuseIdentifier: AppCharacterCollectionGridViewCell.cellIdentifier)
        collectionView.register(AppCharacterCollectionListViewCell.self, forCellWithReuseIdentifier: AppCharacterCollectionListViewCell.cellIdentifier)
        collectionView.register(AppFooterLoadingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: AppFooterLoadingCollectionReusableView.identifier)
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
        viewModel.fetchCharacters()
        
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
}

extension AppCharacterListView: AppCharacterListViewModelDelegate {
    func didSelectCharacter(_ character: AppCharacter) {
        delegate?.appDetailedCharacterListView(self, didSelectCharacter: character)
    }
    
    func didLoadInitialCharacter() {
        spinner.stopAnimating()
        collectionView.isHidden = false
        collectionView.reloadData()  // initial fetcch characters
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
        }
    }
    
    func didLoadMoreCharacters(with newIndexPath:[IndexPath]) {
        collectionView.performBatchUpdates {
            self.collectionView.insertItems(at: newIndexPath)
        }
    }
}


