//
//  AppCharacterInfoCollectionViewCell.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 3.08.2023.
//

import UIKit

final class AppCharacterInfoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "AppCharacterInfoCollectionViewCell"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .tertiarySystemBackground
        contentView.layer.cornerRadius = 7
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints(){
        
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure(viewModel: AppCharacterInfoCollectionViewCellViewModel){
        
    }
}
