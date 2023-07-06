//
//  AppCharacterCollectionViewCell.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 6.07.2023.
//

import UIKit

/// Single  Cell for a character
final class AppCharacterCollectionViewCell: UICollectionViewCell {
    static let cellidentifier = "CollectionCell"
    
    private let imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    
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
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(imageView, nameLabel, statusLabel)
        
        nameLabel.backgroundColor = .systemBlue
        statusLabel.backgroundColor = .systemRed
        
    }
    
    private func layout(){
        /*
         | imageView    |
         | nameLAbel    |
         | statusLabel  |
         */
         
        //  statuLAbel
        NSLayoutConstraint.activate([
            statusLabel.heightAnchor.constraint(equalToConstant: 50),
            statusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            statusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3)
        ])
        //nameLAbel
        NSLayoutConstraint.activate([
            nameLabel.heightAnchor.constraint(equalToConstant: 50),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            nameLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor, constant: -3)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        nameLabel.text = nil
        statusLabel.text = nil
    }
    
    public func configure(with viewModel: AppCharacterCollectionViewCellViewModel){
        
    }
}
