//
//  AppCharacterPhotoCollectionViewCell.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 3.08.2023.
//

import UIKit

final class AppCharacterPhotoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "AppCharacterPhotoCollectionViewCell"
    
    private let imageView:UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
//        imageView.layer.borderWidth = 2
//        imageView.layer.borderColor = UIColor.systemGray5.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        setUpConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints(){
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
            imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -16),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
    
    public func configure(viewModel: AppCharacterPhotoCollectionViewCellViewModel){
        viewModel.fetchImage { [weak self ] result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(data: data)
                }
            case .failure:
                break
            }
        }
    }
}
