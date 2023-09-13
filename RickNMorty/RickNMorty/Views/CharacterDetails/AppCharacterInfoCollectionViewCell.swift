//
//  AppCharacterInfoCollectionViewCell.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 3.08.2023.
//

import UIKit

final class AppCharacterInfoCollectionViewCell: UICollectionViewCell {
    static let cellIdentifier = "AppCharacterInfoCollectionViewCell"
    
    private  let valueLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Earth"
        label.numberOfLines = 0
//        label.backgroundColor = .red
        label.font = .systemFont(ofSize: 20, weight: .light)
        return label
    }()
    
    private  let titleLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "Location"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private  let iconImageView: UIImageView = {
       let icon = UIImageView()
        icon.translatesAutoresizingMaskIntoConstraints = false
        icon.contentMode = .scaleAspectFit
//        icon.image = UIImage(systemName: "globe.americas")
        return icon
    }()
    
    private  let titleContainerView: UIView = {
       let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemGray5
        return view
    }()
    
    private let dividerView : UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .secondarySystemFill
        return view
    }()
    
    
    // MARK: -init
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemGray6
        contentView.layer.masksToBounds = true
        contentView.layer.cornerRadius = 7
        contentView.addSubviews(titleContainerView,dividerView, valueLabel, iconImageView)
        titleContainerView.addSubview(titleLabel)
        setUpConstraints ()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpConstraints() {
        
        // titleContaineView
        NSLayoutConstraint.activate([
            titleContainerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
            titleContainerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            titleContainerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleContainerView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.33)
            
        ])
            // titleLabel
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: titleContainerView.topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: titleContainerView.leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: titleContainerView.rightAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: titleContainerView.bottomAnchor)
        ])
        // dividerView
        NSLayoutConstraint.activate([
            dividerView.leftAnchor.constraint(equalTo: titleContainerView.leftAnchor),
            dividerView.rightAnchor.constraint(equalTo: titleContainerView.rightAnchor),
            dividerView.topAnchor.constraint(equalTo: titleContainerView.bottomAnchor),
            dividerView.heightAnchor.constraint(equalToConstant: 1.5)
        ])
        
        // valueLabel
        NSLayoutConstraint.activate([
            valueLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 10),
            valueLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -10),
            valueLabel.topAnchor.constraint(equalTo: titleContainerView.bottomAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        // iconImageView
        NSLayoutConstraint.activate([
            iconImageView.heightAnchor.constraint(equalToConstant: 35),
            iconImageView.widthAnchor.constraint(equalToConstant: 35),
            iconImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -30),
            iconImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15)
        ])
    }
    
    override func prepareForReuse() {  // hücreleri tekrar kullanabilmek için nille
        super.prepareForReuse()
        valueLabel.text = nil
        titleLabel.text = nil
        iconImageView.image = nil
        
        dividerView.backgroundColor = nil
        iconImageView.tintColor = .label
        titleLabel.textColor = .label
    }
    
    public func configure(viewModel: AppCharacterInfoCollectionViewCellViewModel){
        titleLabel.text = viewModel.title
        valueLabel.text = viewModel.displayValue
        iconImageView.image = viewModel.iconImage
        
        iconImageView.tintColor = viewModel.charColor
        titleLabel.textColor = viewModel.charColor
        dividerView.backgroundColor = viewModel.charColor
    }
}
