//
//  FavoritesCell.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 5.02.2025.
//

import Foundation

import UIKit

protocol FavoritesCellDelegate: AnyObject {
    func didTapDeleteButton(selectedForDelete: AppCharacter)
}

class FavoritesCell: UICollectionViewCell {
    
    static let cellIdentifier = String(describing: FavoritesCell.self)
    
    private var favoriteCharacter: AppCharacter?
    weak var delegate: FavoritesCellDelegate?
    
    
    let characterImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        
        return image
    }()
    
    let characterLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints   = false
        label.textColor                                   = .label
        label.adjustsFontSizeToFitWidth                   = true
        label.minimumScaleFactor                          = 0.9
        label.lineBreakMode                               = .byTruncatingTail
        label.font                                        = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    let unfavoriteButton: UIButton = {
        let button = UIButton(frame: .zero)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureCell()
    }
    
    func setCell(character: AppCharacter) {
        self.favoriteCharacter = character
        self.characterLabel.text = character.name
        self.characterImageView.backgroundColor = .label
            
        guard let url = URL(string: character.image) else {
            print("URL Error")
            return
        }
        AppImageLoader.shared.downloadImage(url) { [weak self] result in
            switch result {
            case .success(let data):
                    self?.characterImageView.image = UIImage(data: data)
            case .failure(let error):
                    print("Error downloading image: \(error)")
            }
        }
        
    }
    
    private func configureCell() {
        let padding: CGFloat = 8
        
        addSubview(characterImageView)
        addSubview(characterLabel)
        addSubview(unfavoriteButton)
        
        characterLabel.textAlignment = .center
        layer.borderColor = UIColor.label.cgColor
        layer.borderWidth = 2
        
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .regular, scale: .large)
        let deleteTrash = UIImage(systemName: "trash.circle", withConfiguration: largeConfig)
        unfavoriteButton.setImage(deleteTrash, for: .normal)
        unfavoriteButton.tintColor = .systemRed
        unfavoriteButton.translatesAutoresizingMaskIntoConstraints = false
        unfavoriteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
        characterImageView.translatesAutoresizingMaskIntoConstraints = false
        characterLabel.translatesAutoresizingMaskIntoConstraints = false
        unfavoriteButton.translatesAutoresizingMaskIntoConstraints = false
        
        
        NSLayoutConstraint.activate([
            characterImageView.topAnchor.constraint(equalTo: topAnchor),
            characterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            characterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            characterImageView.bottomAnchor.constraint(equalTo: characterLabel.topAnchor, constant: -padding),
            
            characterLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            characterLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            characterLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding),
            characterLabel.heightAnchor.constraint(equalToConstant: 28),
            
            unfavoriteButton.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            unfavoriteButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            unfavoriteButton.widthAnchor.constraint(equalToConstant: 30),
            unfavoriteButton.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
    @objc func deleteButtonTapped() {
        guard let selectedForDelete = favoriteCharacter else {
            print("selecteForDelete Error")
            return
        }
        delegate?.didTapDeleteButton(selectedForDelete: selectedForDelete)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
