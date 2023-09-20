//
//  AppSettingsView.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 20.09.2023.
//

import UIKit

final class AppSettingsView: UIView {
    
    private let viewModel: AppSettingsViewViewModel
    
    
    init(frame: CGRect, viewModel:AppSettingsViewViewModel) {
        self.viewModel = viewModel
        
        super.init(frame: frame)
        
        setUp()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp(){
        
    }
    private func layout(){
        
    }
}
