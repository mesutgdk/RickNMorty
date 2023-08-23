//
//  AppCharacterEpisodeCollectionViewCell.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 3.08.2023.
//

import UIKit

final class AppCharacterEpisodeCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "AppCharacterEpisodeCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints(){
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure(viewModel: AppCharacterEpisodeCollectionViewCellViewModel){
        
    }
}
