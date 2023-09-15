//
//  AppCharacterEpisodeCollectionViewCell.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 3.08.2023.
//

import UIKit

final class AppCharacterEpisodeCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "AppCharacterEpisodeCollectionViewCell"
    
    private  let seasonLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Location"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()
    
    private  let nameLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Location"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()
    
    private  let airDateLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Location"
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 15, weight: .light)
        return label
    }()
    
    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp(){
        contentView.addSubviews(nameLabel,seasonLabel,airDateLabel)
        contentView.backgroundColor = .systemGray5
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 2  // çerçeve kalınlık
    }
    
    private func layout(){
        // seasonLabel
        NSLayoutConstraint.activate([
            seasonLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            seasonLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            seasonLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),
            seasonLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3)
        ])
        // nameLabel
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: seasonLabel.bottomAnchor, constant: 2),
            nameLabel.leadingAnchor.constraint(equalTo: seasonLabel.leadingAnchor),
            nameLabel.trailingAnchor.constraint(equalTo: seasonLabel.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3)

        ])
        // airDateLabel
        NSLayoutConstraint.activate([
            airDateLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 2),
            airDateLabel.leadingAnchor.constraint(equalTo: seasonLabel.leadingAnchor),
            airDateLabel.trailingAnchor.constraint(equalTo: seasonLabel.trailingAnchor),
            airDateLabel.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.3)
        ])
    }
    override func prepareForReuse() {  // hücreleri tekrar kullanabilmek için nille
        super.prepareForReuse()
        nameLabel.text = nil
        seasonLabel.text = nil
        airDateLabel.text = nil
    }
    
    public func configure(viewModel: AppCharacterEpisodeCollectionViewCellViewModel){
        viewModel.registerForData { [weak self] data in
//            Main Queue
            self?.nameLabel.text = data.name
            self?.seasonLabel.text = "Episode "+data.episode
            self?.airDateLabel.text = "Aired On "+data.air_date
        }
        viewModel.fetchEpisode()
        contentView.layer.borderColor = viewModel.borderColor.cgColor   // çerçeve renk

    }
}
