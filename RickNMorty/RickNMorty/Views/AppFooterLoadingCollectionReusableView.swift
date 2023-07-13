//
//  AppFooterLoadingCollectionReusableView.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 11.07.2023.
//

import UIKit

final class AppFooterLoadingCollectionReusableView: UICollectionReusableView {
   static let identifier = "AppFooterLoadingCollectionReusableView"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layyout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    private func setup (){
        backgroundColor = .systemBlue
    }
    private func layyout(){
        
    }
}
