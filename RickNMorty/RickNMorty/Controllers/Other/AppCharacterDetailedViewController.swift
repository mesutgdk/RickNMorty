//
//  AppCharacterDetailedViewController.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 7.07.2023.
//

import UIKit

final class AppCharacterDetailedViewController: UIViewController {

    private let viewModel: AppCharacterViewViewModel
    
    init(viewModel: AppCharacterViewViewModel ) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
    }
    
    private func setup(){
        view.backgroundColor = .systemBackground
        title = viewModel.title
    }
    
    private func layout(){
        
    }

    
}
