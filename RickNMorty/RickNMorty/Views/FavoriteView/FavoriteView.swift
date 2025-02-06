//
//  FavoriteView.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 5.02.2025.
//

import UIKit

protocol FavoritesViewDelegate: AnyObject {
 
}

class FavoritesView: UIView {
    weak var delegate : FavoritesViewDelegate?
    
    private let viewModel: FavoriteViewModel
    
 
    init(frame: CGRect, viewModel: FavoriteViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
//        setup()
//        layout()
//        
//        setupHandlers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

