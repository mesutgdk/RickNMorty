//
//  AppEpisodeDetailView.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 13.09.2023.
//

import UIKit

final class AppEpisodeDetailView: UIView {
    
    private var viewModel: AppEpisodeListViewViewModel?
    
    private var collectionView: UICollectionView?
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        layoutCollection()
        self.collectionView = createCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    // MARK: - Private func

    private func setUp(){
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .yellow
    }
    
    private func layoutCollection(){
        // CollectionView
        NSLayoutConstraint.activate([
            
        ])
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout{ section, _ in
            
            return self.layout(for:section)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }
    // MARK: - Public func

    public func configure(with viewModel:AppEpisodeDetailViewViewModel){
        
    }
}
extension AppEpisodeDetailView{
    func layout(for section: Int) -> NSCollectionLayoutSection {
        
    }
}
