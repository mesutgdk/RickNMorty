//
//  AppEpisodeDetailView.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 13.09.2023.
//

import UIKit

final class AppEpisodeDetailView: UIView {
    
    private var viewModel: AppEpisodeDetailViewViewModel? {
        didSet {
            spinner.stopAnimating()
            self.collectionView?.reloadData()
            self.collectionView?.isHidden = false
            UIView.animate(withDuration: 0.5) {
                self.collectionView?.alpha = 1
            }
        }
    }
    
    private var collectionView: UICollectionView?
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.hidesWhenStopped = true
        return spinner
    }()
    
    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    // MARK: - Private func

    private func setUp(){
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground

        let collectionView = createCollectionView()
        addSubviews(collectionView,spinner)
        
        self.collectionView = collectionView
        
        spinner.startAnimating()
    }
    
    private func layout(){
        guard let collectionView = collectionView else{
            return
        }
        // Spinner
        NSLayoutConstraint.activate([
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
        // CollectionView
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout{ section, _ in
            
            return self.itemLayout(for:section)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(AppEpisodeInfoCollectionViewCell.self, forCellWithReuseIdentifier: AppEpisodeInfoCollectionViewCell.cellIdentifier)
        collectionView.register(AppCharacterCollectionGridViewCell.self, forCellWithReuseIdentifier: AppCharacterCollectionGridViewCell.cellIdentifier)
        return collectionView
    }
    // MARK: - Public func

    public func configure(with viewModel:AppEpisodeDetailViewViewModel){
        self.viewModel = viewModel
    }
}
// MARK: - CollectionView Delegate and DataSource
extension AppEpisodeDetailView: UICollectionViewDelegate,UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel?.cellViewModels.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let sections = viewModel?.cellViewModels else {
            return 0
        }
        
        let sectionType = sections[section]
        switch sectionType {
        case .character(let viewModels):
            return viewModels.count
        case.information(let viewModels):
            return viewModels.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let sections = viewModel?.cellViewModels else {
            fatalError("No ViewModel for EpisodeDetailCell")
        }
        
        let sectionType = sections[indexPath.section]
        
        switch sectionType {
        case .information(let viewModels):
            let cellViewModel = viewModels[indexPath.row]
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppEpisodeInfoCollectionViewCell.cellIdentifier, for: indexPath) as? AppEpisodeInfoCollectionViewCell else {
                fatalError("")
            }
            cell.configure(with: cellViewModel)
            return cell
            
        case .character(let viewModels):
            let cellViewModel = viewModels[indexPath.row]
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppCharacterCollectionGridViewCell.cellIdentifier, for: indexPath) as? AppCharacterCollectionGridViewCell else {
                fatalError("")
            }
            cell.configure(with: cellViewModel)
            return cell
        
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}

// MARK: - CollectionviewItemsLayout

extension AppEpisodeDetailView{
    func itemLayout(for section: Int) -> NSCollectionLayoutSection {
        guard let sections = viewModel?.cellViewModels else {
            return createInfoLayout()
        }
        switch sections[section]{
        case .information:
            return createInfoLayout()
        case .character:
            return createCharacterLayout()
        }
    }
    func createInfoLayout() -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 10, bottom: 2, trailing: 10)
        let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(100)),
                                                     subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    func createCharacterLayout () -> NSCollectionLayoutSection {
        
        let item = NSCollectionLayoutItem(layoutSize: .init(
            widthDimension: .fractionalWidth(0.33),
            heightDimension: .fractionalHeight(1)))
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 10, bottom: 2, trailing: 10)
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(180)),
            subitems: [item, item, item]
        )
        
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
}
