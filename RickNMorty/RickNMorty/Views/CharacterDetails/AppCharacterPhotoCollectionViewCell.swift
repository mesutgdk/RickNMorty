//
//  AppCharacterPhotoCollectionViewCell.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 3.08.2023.
//

import UIKit

final class AppCharacterPhotoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "AppCharacterPhotoCollectionViewCell"
    
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
    
    public func configure(viewModel: AppCharacterPhotoCollectionViewCellViewModel){
        
    }
}
