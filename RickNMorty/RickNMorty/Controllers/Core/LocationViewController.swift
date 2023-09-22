//
//  LocationViewController.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 26.06.2023.
//

import UIKit

final class LocationViewController: UIViewController {
    
    private let locationPrimaryView = AppLocationView()
    
    private let viewModel = AppLocationViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
        
        addSearchButton()
    }
    private func setup(){
        title = "Locations"
        view.backgroundColor = .systemBackground
        view.addSubview(locationPrimaryView)
        
        viewModel.fetchLocations()
        
        viewModel.delegate = self
    }
    private func layout(){
        //locationView
        NSLayoutConstraint.activate([
            locationPrimaryView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            locationPrimaryView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            locationPrimaryView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            locationPrimaryView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
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
// MARK: - AppLocationViewModelDelegate

extension LocationViewController: AppLocationViewModelDelegate {
    func didFetchInitialLocation() {
        <#code#>
    }
    
    
}
