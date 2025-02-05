//
//  AppLocationTableViewCell.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 22.09.2023.
//

import UIKit

final class AppLocationTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "AppLocationTableViewCell"
    
    private let nameLabel : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    }()
    
    private let typeLabel : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .secondaryLabel
        return label
    }()
    
    private let dimensionLabel : UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .secondaryLabel
        return label
    }()
    
    // MARK: - Init

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
      
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        nameLabel.text = nil
        typeLabel.text = nil
        dimensionLabel.text = nil
    }
    
    private func setup(){
//        contentView.backgroundColor = .systemBackground
        contentView.addSubviews(nameLabel,typeLabel,dimensionLabel)
        accessoryType = .disclosureIndicator
        
    }
    private func layout(){
        
        // nameLabel
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10),
            nameLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 8),
            nameLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -8)
        ])
        // typeLabel
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor,constant: 10),
            typeLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 8),
            typeLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -8)
        ])
        // dimensionLabel
        NSLayoutConstraint.activate([
            dimensionLabel.topAnchor.constraint(equalTo: typeLabel.bottomAnchor,constant: 10),
            dimensionLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor,constant: 8),
            dimensionLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor,constant: -8),
            dimensionLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -10)
        ])
        /*
         nameLabel
         typeLabel
         dimesionLabel
         */
    }
    
    public func configure(with viewModel: AppLocationTableViewCellViewModel){
        nameLabel.text = viewModel.name
        typeLabel.text = viewModel.type
        dimensionLabel.text = viewModel.deminsion
    }
}
