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
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 25
        imageView.layer.borderWidth = 1
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.textAlignment = .center
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
        
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowColor = UIColor.label.cgColor
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowOffset = CGSize(width: -2, height: 2)
        contentView.layer.shadowRadius = 8
        
//        nameLabel.backgroundColor = .gray
//        statusLabel.backgroundColor = .systemRed
//        imageView.backgroundColor = .systemGreen
        
    }
    
    private func layout(){
        /*
         | imageView    |
         | nameLAbel    |
         | statusLabel  |
         */
         
        //  statuLAbel
        NSLayoutConstraint.activate([
            statusLabel.heightAnchor.constraint(equalToConstant: 30),
            statusLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            statusLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3)
        ])
        
        //nameLAbel
        NSLayoutConstraint.activate([
            nameLabel.heightAnchor.constraint(equalToConstant: 30),
            nameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            nameLabel.bottomAnchor.constraint(equalTo: statusLabel.topAnchor)
        ])
        
        //imageView
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: nameLabel.topAnchor, constant: -5)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        imageView.layer.borderColor = nil
        nameLabel.text = nil
        statusLabel.text = nil
    }
    
    public func configure(with viewModel: AppCharacterCollectionViewCellViewModel){
        
        nameLabel.text = viewModel.characterName
        statusLabel.text = viewModel.characterStatusText
        statusLabel.textColor = viewModel.characterStatusTextColor
        imageView.layer.borderColor = viewModel.characterStatusTextColor.cgColor
        viewModel.fetchImage { [weak self] result in    // to avoid retain cycle
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    self?.imageView.image = image
                }
            case .failure(let error):
                print(String(describing: error))
                break
            }
        }
    }
}
