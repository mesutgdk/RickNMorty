//
//  AppNoSearchResultView.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 27.09.2023.
//

import UIKit

final class AppNoSearchResultView: UIView{
    
    private let viewModel = AppNoSearchResultViewViewModel ()
    
    private let iconView: UIImageView = {
        let iconView = UIImageView()
        iconView.translatesAutoresizingMaskIntoConstraints = false
        iconView.contentMode = .scaleAspectFit
        iconView.tintColor = .systemBlue
        return iconView
    } ()
    
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .medium)
        return label
    } ()
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        isHidden = true
        translatesAutoresizingMaskIntoConstraints = false
        addSubviews(iconView,label)
    }
    private func layout(){
        // iconImage
        NSLayoutConstraint.activate([
            iconView.widthAnchor.constraint(equalToConstant: 100),
            iconView.heightAnchor.constraint(equalToConstant: 100),
            iconView.centerXAnchor.constraint(equalTo: centerXAnchor),
            iconView.topAnchor.constraint(equalTo: topAnchor)
        ])
        
        // label
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: 10),
            label.leftAnchor.constraint(equalTo: leftAnchor),
            label.rightAnchor.constraint(equalTo: rightAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor),
            label.heightAnchor.constraint(greaterThanOrEqualToConstant: 60)
        ])
    }
    
    private func configure(){
        label.text = viewModel.title
        iconView.image = viewModel.image
    }
}

