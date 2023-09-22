//
//  AppLocationTableViewCell.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 22.09.2023.
//

import UIKit

final class AppLocationTableViewCell: UITableViewCell {
    
    static let cellIdentifier = "AppLocationTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    public func configure(with viewModel: AppLocationTableViewCellViewModel){
        
    }
}
