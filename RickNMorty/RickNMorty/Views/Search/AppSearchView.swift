//
//  AppSearchView.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 26.09.2023.
//

import UIKit

final class AppSearchView: UIView {
    
    private let viewModel: AppSearchViewViewModel
    
    // MARK: - Init

    init(frame: CGRect, viewModel: AppSearchViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        backgroundColor = .red
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func layout (){
        
    }
    
}
