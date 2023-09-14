//
//  AppEpisodeListView.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 14.09.2023.
//

import UIKit

protocol AppEpisodeViewDelegate: AnyObject {
    func appEpisodeListView(_ episodeListView: AppEpisodeListView, didSelectEpisode episode: AppEpisode)
}

/// View that handles showing list of episodes, loader, etc.
final class AppEpisodeListView: UIView {
    
    
    public weak var delegate: AppEpisodeViewDelegate?

    private let viewModel = AppEpisodeListViewViewModel()
    
    private let spinner : UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    } ()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(AppCharacterEpisodeCollectionViewCell.self, forCellWithReuseIdentifier: AppCharacterEpisodeCollectionViewCell.cellIdentifier)
        
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
        viewModel.fetchEpisodes()
        
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
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func setupCollectionView(){
        collectionView.dataSource = viewModel
        collectionView.delegate = viewModel
        
    }
}

extension AppEpisodeListView: AppEpisodeListViewModelDelegate {
    
    func didSelectEpisode(_ episode: AppEpisode) {
        delegate?.appEpisodeListView(self, didSelectEpisode: episode )
    }
    
    func didLoadInitialEpisode() {
        spinner.stopAnimating()
        collectionView.isHidden = false
        collectionView.reloadData()  // initial fetcch characters
        UIView.animate(withDuration: 0.4) {
            self.collectionView.alpha = 1
        }
    }
    
    func didLoadMoreEpisodes(with newIndexPath:[IndexPath]) {
        collectionView.performBatchUpdates {
            self.collectionView.insertItems(at: newIndexPath)
        }
    }
}



