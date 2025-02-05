//
//  AppTableLoadingFooterView.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 16.10.2023.
//

import UIKit

final class AppTableLoadingFooterView: UIView {
    
    private let spinner : UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
//        translatesAutoresizingMaskIntoConstraints = false
        addSubview(spinner)
        spinner.startAnimating()
    }
    
    private func layout(){
        // spinner
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 55),
            spinner.heightAnchor.constraint(equalToConstant: 55),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
//        // self
//        NSLayoutConstraint.activate([
//            self.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width),
//            self.heightAnchor.constraint(equalToConstant: 100)
//        ])
    }
    
    
}
