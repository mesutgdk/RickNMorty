//
//  EpisodeViewController.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 26.06.2023.
//

import UIKit

final class EpisodeViewController: UIViewController {

    private let episodeListView = AppEpisodeListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        
        setup()
        layout()
        
        addSearchButton()
    }
    
    private func setup() {
        view.addSubview(episodeListView)

        view.backgroundColor = .systemBackground
        title = "Episode"
        
        episodeListView.delegate = self

    }
    
    private func layout() {
        // characterListView
        NSLayoutConstraint.activate([
            episodeListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            episodeListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            episodeListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            episodeListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
// MARK: - AppEpisodeListViewDelegate

extension EpisodeViewController: AppEpisodeViewDelegate {
    
    func appEpisodeListView(_ episodeListView: AppEpisodeListView, didSelectEpisode episode: AppEpisode) {
        // open a controller for that episode
        let detailedVC = AppEpisodeDetailViewController(url: URL(string: episode.url))
        

        detailedVC.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(detailedVC, animated: true)
        // detailed is a rootVC with navC, so navC will push
    }
  
}
// MARK: - Search Button
extension EpisodeViewController {
    private func addSearchButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(searchButtonTapped))
    }
    
    @objc private func searchButtonTapped(){
        let vc = AppSearchViewController(config: AppSearchViewController.Config(type: .episode))
        vc.navigationItem.largeTitleDisplayMode = .never
        navigationController?.pushViewController(vc, animated: true)
    }
}

