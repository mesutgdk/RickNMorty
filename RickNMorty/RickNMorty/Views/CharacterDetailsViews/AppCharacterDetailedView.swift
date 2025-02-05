//
//  AppCharacterDetailedView.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 7.07.2023.
//

import UIKit

/// View for single character
final class AppCharacterDetailedView: UIView {
    
    public var collectionView: UICollectionView?
    
    private let viewModel: AppCharacterDetailedViewViewModel
    
    private let spinner : UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    } ()
    
    // MARK: - Init
    init(frame: CGRect, viewModel: AppCharacterDetailedViewViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: frame)
        
        setUp()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp(){
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        
        let collectionView = createCollectionView()
        self.collectionView = collectionView
        
        addSubviews(collectionView,spinner)
    }
    private func layout(){
        guard let collectionView = collectionView else {
            return
        }
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
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(AppCharacterPhotoCollectionViewCell.self, forCellWithReuseIdentifier: AppCharacterPhotoCollectionViewCell.cellIdentifier)
        collectionView.register(AppCharacterInfoCollectionViewCell.self, forCellWithReuseIdentifier: AppCharacterInfoCollectionViewCell.cellIdentifier)
        collectionView.register(AppCharacterEpisodeCollectionViewCell.self, forCellWithReuseIdentifier: AppCharacterEpisodeCollectionViewCell.cellIdentifier)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection{
        
        let sectionType = viewModel.section
        
        switch sectionType[sectionIndex] {
        case .photo:
            return viewModel.createPhotoSectionLayout()
        case .information:
            return viewModel.createInfoSectionLayout()
        case .episodes:
            return viewModel.createEpisodeSectionLayout()
        }
    }   
}
