//
//  AppEpisodeDetailViewController.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 13.09.2023.
//

import UIKit

/// VC to show details about single episode
final class AppEpisodeDetailViewController: UIViewController {
    
    private let url: URL?
    
    // MARK: - init

    init(url:URL?) {
        self.url = url
        
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
        title = "Episode"
        view.backgroundColor = .systemOrange
    }
    
}
