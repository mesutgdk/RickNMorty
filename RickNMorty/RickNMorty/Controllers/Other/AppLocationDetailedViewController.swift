//
//  AppLocationDetailedViewController.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 25.09.2023.
//

import UIKit

final class AppLocationDetailedViewController: UIViewController {

    private let location : AppCharacter
    
    // MARK: - Init

    init(location: AppCharacter) {
        self.location = location
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        layout()
    }
    
    private func setup(){
      title = "Locatin"
        view.backgroundColor = .red
    }
    
    private func layout(){
        
    }
    

}
