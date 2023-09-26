//
//  AppLocationDetailedViewController.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 25.09.2023.
//

import UIKit

final class AppLocationDetailedViewController: UIViewController {
    
    private let viewModel : AppLocationDetailViewViewModel
    
    private let detailView = AppLocationDetailView()
    // MARK: - init
    
    init(location: AppLocation) {
        let url = URL(string: location.url)
        self.viewModel = AppLocationDetailViewViewModel(endpointUrl: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        layout()
        addShareButton()
    }
    
    private func setup(){
        title = "Location"
        view.backgroundColor = .systemBackground
        view.addSubviews(detailView)
        
        detailView.delegate = self
        
        viewModel.delegate = self
        viewModel.fetchLocationData()
    }
    
    private func layout(){
        NSLayoutConstraint.activate([
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
    private func addShareButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButtonTapped))
    }
    
    @objc private func shareButtonTapped(){
        
    }
    
}
// MARK: - AppLocationDetailViewViewModelDelegate

extension AppLocationDetailedViewController: AppLocationDetailViewViewModelDelegate {
    func didFetchLocationDetail() {
        detailView.configure(with: viewModel)
    }
}

// MARK: - AppEpisodeDetailViewDelegate  "now can access character from episodedetail page"

extension AppLocationDetailedViewController: AppLocationDetailsViewDelegate {
    func appLocationDetailView(_ detailedView: AppLocationDetailView, didSelect character: AppCharacter) {
        let vc = AppCharacterDetailedViewController(viewModel: .init(character: character))
        vc.title = character.name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}
