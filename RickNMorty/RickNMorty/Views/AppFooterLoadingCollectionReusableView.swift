//
//  AppFooterLoadingCollectionReusableView.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 11.07.2023.
//

import UIKit

final class AppFooterLoadingCollectionReusableView: UICollectionReusableView {
   static let identifier = "AppFooterLoadingCollectionReusableView"
    
    private let spinner : UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layyout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    private func setup (){
        backgroundColor = .systemBackground
        
        addSubview(spinner)
    }
    
    private func layyout(){
        // spinner
        NSLayoutConstraint.activate([
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
    public func startAnimating(){
        spinner.startAnimating()
    }
}
