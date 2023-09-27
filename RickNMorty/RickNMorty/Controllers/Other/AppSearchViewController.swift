//
//  AppSearchViewController.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 15.09.2023.
//

import UIKit

// dinamic search option view
// Render results
// Render no result zero state
// Searching / API Calls

final class AppSearchViewController: UIViewController {

    /// Configuration for search
    struct Config {
        enum `Type` {
            case character // name | status | gender
            case episode // name
            case location // name | type
            
            var title: String {
                switch self {
                case .character:
                    return "Search Character"
                case .episode:
                    return "Search Episode"
                case .location:
                    return "Sarch Location"
                }
            }
        }
        
        let type : `Type`
    }
    
    private let config: Config
    
    // MARK: - Init
    init(config: Config) {
        self.config = config
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    private func setup(){
        title = config.type.title
        view.backgroundColor = .systemBackground
    }

}
