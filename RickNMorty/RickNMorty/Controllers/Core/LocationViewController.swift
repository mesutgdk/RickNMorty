//
//  LocationViewController.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 26.06.2023.
//

import UIKit

final class LocationViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        title = "Locations"
        
        addSearchButton()
    }
}
// MARK: - Search Button
extension LocationViewController {
    private func addSearchButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
    }
    
    @objc private func searchButtonTapped(){
        let vc = AppSearchViewController(config: AppSearchViewController.Config(type: .location))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
        
    }
}
