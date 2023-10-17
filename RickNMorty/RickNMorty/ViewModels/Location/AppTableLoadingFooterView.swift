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
        translatesAutoresizingMaskIntoConstraints = false
        addSubview(spinner)
        spinner.startAnimating()
    }
    
    private func layout(){
        
    }
    
    
}
