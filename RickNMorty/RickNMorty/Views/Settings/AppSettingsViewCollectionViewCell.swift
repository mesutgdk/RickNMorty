//
//  AppSettingsViewCollectionViewCell.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 20.09.2023.
//

import UIKit

final class AppSettingsViewCollectionViewCell: UICollectionViewCell {
    
    static let cellIdentifier = "AppSettingsViewCollectionViewCell"
    
    let imageView : UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(systemName: "star")
        return imageView
    }()
    
    let titleLabel : UILabel = {
        let label = UILabel()
        label.text = "Hadi ama çalış"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        layout()
     
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
    }
    
    private func setup(){
        
        contentView.addSubviews(imageView,titleLabel)
        
        contentView.backgroundColor = .secondarySystemBackground
        layer.masksToBounds = true
        layer.cornerRadius = 8
        layer.borderWidth = 1
    }
    
    private func layout(){
        //titleLabel
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2)
        ])
        //valueLabel
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 4),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 8)
        ])
    }
    
    func configure(with viewModel:AppSettingsCellViewModel){
        imageView.image = viewModel.image
        imageView.tintColor = viewModel.imageColor
                
        titleLabel.text = viewModel.title
        
//        layer.borderColor = viewModel.imageColor.cgColor

    }
}
