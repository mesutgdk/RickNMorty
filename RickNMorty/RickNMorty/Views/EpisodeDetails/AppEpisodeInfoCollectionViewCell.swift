//
//  AppEpisodeInfoCollectionViewCell.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 16.09.2023.
//

import UIKit

final class AppEpisodeInfoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "AppEpisodeInfoCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .green
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func configure(with viewModel:AppEpisodeInfoCollectionViewCellViewModel){
        
    }
}
