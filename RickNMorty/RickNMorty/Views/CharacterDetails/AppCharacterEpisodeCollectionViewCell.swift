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
        label.font = .systemFont(ofSize: 22, weight: .regular)
        return label
    }()
    
    private  let airDateLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Location"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 18, weight: .light)
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
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 10
        contentView.layer.borderWidth = 2  // çerçeve kalınlık
        contentView.layer.borderColor = UIColor.systemRed.cgColor   // çerçeve renk
    }
    
    private func layout(){
        NSLayoutConstraint.activate([
            
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
    }
}
