//
//  AppEpisodeInfoCollectionViewCell.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 16.09.2023.
//

import UIKit

final class AppEpisodeInfoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "AppEpisodeInfoCollectionViewCell"
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let valueLabel : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.numberOfLines = 0
        label.textAlignment = .left
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .secondarySystemBackground
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        valueLabel.text = nil
    }
    
    private func setup(){
        contentView.addSubviews(titleLabel,valueLabel)
        layer.masksToBounds = true
        layer.cornerRadius = 8
        layer.borderWidth = 1.5
        layer.borderColor = UIColor.secondaryLabel.cgColor
//        titleLabel.backgroundColor = .red
//        valueLabel.backgroundColor = .blue
    }
    
    private func layout(){
        //titleLabel
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8),
            titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            titleLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4)
        ])
        //valueLabel
        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            valueLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -4),
            valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            valueLabel.leftAnchor.constraint(equalTo: titleLabel.rightAnchor, constant: 8)
        ])
    }
    
    func configure(with viewModel:AppEpisodeInfoCollectionViewCellViewModel){
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.value
    }
}
