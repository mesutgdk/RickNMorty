//
//  AppCharacterCollectionListViewCell.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 15.09.2023.
//

import UIKit

final class AppCharacterCollectionListViewCell: UICollectionViewCell {
    static let cellIdentifier = "ListCollectionCell"
    
    private let imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        imageView.layer.borderWidth = 1
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 24, weight: .medium)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = .secondaryLabel
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .medium)
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
    
    // MARK: - setup and layout

    private func setup(){
        contentView.backgroundColor = .secondarySystemBackground
        contentView.addSubviews(imageView, nameLabel, statusLabel)
        
        contentView.layer.cornerRadius = 8
        contentView.layer.shadowColor = UIColor.label.cgColor
        contentView.layer.shadowOpacity = 0.3
        contentView.layer.shadowOffset = CGSize(width: -2, height: 2)
        contentView.layer.shadowRadius = 8
        
        
    }
    
    private func layout(){
        /*
                        | nameLAbel    |
         | imageView |
                        | statusLabel  |
        
         */
        
        //imageView
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 4),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor)
        ])
        
        //nameLAbel
        NSLayoutConstraint.activate([
//            nameLabel.heightAnchor.constraint(equalToConstant: 40),
            nameLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            nameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8)
        ])
        
        //  statuLabel
        NSLayoutConstraint.activate([
//            statusLabel.heightAnchor.constraint(equalToConstant: 30),
            statusLabel.leadingAnchor.constraint(equalTo: nameLabel.leadingAnchor, constant: 4),
            statusLabel.trailingAnchor.constraint(equalTo: nameLabel.trailingAnchor, constant: -4),
            statusLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            statusLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
        
      
    }
    
    // MARK: - Prepare to reuse

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        imageView.layer.borderColor = nil
        nameLabel.text = nil
        statusLabel.text = nil
    }
    
    // MARK: - Configure

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
