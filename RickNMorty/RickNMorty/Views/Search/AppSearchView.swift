//
//  AppSearchView.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 26.09.2023.
//

import UIKit

final class AppSearchView: UIView {
    
    private let viewModel: AppSearchViewViewModel
    
    // MARK: - Subviews
    
    // MARK: - SearchInPutView(bar, selection buttons)
    
    // MARK: - No result View
    private let noResultView = AppNoSearchResultView()
    
    // MARK: - Result collectionView

    
    // MARK: - Init

    init(frame: CGRect, viewModel: AppSearchViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        addSubviews(noResultView)
        backgroundColor = .red
        translatesAutoresizingMaskIntoConstraints = false
        noResultView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout (){
        // noResultView
        NSLayoutConstraint.activate([
            noResultView.centerXAnchor.constraint(equalTo:centerXAnchor),
            noResultView.centerYAnchor.constraint(equalTo: centerYAnchor),
            noResultView.widthAnchor.constraint(equalToConstant: 170),
            noResultView.heightAnchor.constraint(equalToConstant: 170)
        ])
 
    }
    
}
// MARK: - CollectionView Delegate and DataSource
extension AppSearchView: UICollectionViewDelegate, UICollectionViewDataSource{

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}

