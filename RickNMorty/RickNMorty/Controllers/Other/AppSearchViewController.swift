//
//  AppSearchViewController.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 15.09.2023.
//

import UIKit

final class AppSearchViewController: UIViewController {

    struct Config {
        enum `Type` {
            case character
            case episode
            case location
        }
        
        let type : `Type`
    }
    
    private let config: Config
    
    init(config: Config) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    private func setup(){
        title = "Search"
        view.backgroundColor = .systemBackground
    }

}
