//
//  AppEpisodeDetailViewController.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 13.09.2023.
//

import UIKit

/// VC to show details about single episode
final class AppEpisodeDetailViewController: UIViewController{
    
    private let viewModel : AppEpisodeDetailViewViewModel
    
    private let detailView = AppEpisodeDetailView()
    // MARK: - init
    
    init(url:URL?) {
        self.viewModel = AppEpisodeDetailViewViewModel(endpointUrl: url)
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
        title = "Episode"
        view.backgroundColor = .systemBackground
        view.addSubviews(detailView)
        
        detailView.delegate = self
        
        viewModel.delegate = self
        viewModel.fetchEpisodeData()
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
// MARK: - AppEpisodeDetailViewViewModelDelegate

extension AppEpisodeDetailViewController: AppEpisodeDetailViewViewModelDelegate {
    func didFetchEpisodeDetail() {
        detailView.configure(with: viewModel)
    }
}

// MARK: - AppEpisodeDetailViewDelegate  "now can access character from episodedetail page"

extension AppEpisodeDetailViewController: AppEpisodeDetailViewDelegate {
    func appEpisodeDetailView(_ detailedView: AppEpisodeDetailView, didSelect character: AppLocation) {
        let vc = AppCharacterDetailedViewController(viewModel: .init(character: character))
        vc.title = character.name
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
