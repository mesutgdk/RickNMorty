//
//  AppCharacterDetailedViewController.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 7.07.2023.
//

import UIKit

final class AppCharacterDetailedViewController: UIViewController {
    

    private let viewModel: AppCharacterDetailedViewViewModel
    
    private let detailedView : AppCharacterDetailedView
    
    // MARK: - Init
//         to pass data with view model, it displays which cell we choose
    init(viewModel: AppCharacterDetailedViewViewModel ) {
        self.viewModel = viewModel
        self.detailedView = AppCharacterDetailedView(frame: .zero, viewModel: viewModel)
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
        view.backgroundColor = .systemBackground
        title = viewModel.title
        view.addSubview(detailedView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .action,
            target: self,
            action: #selector(didTapShare)
        )
//        viewModel.fetchCharacterData()
        detailedView.collectionView?.delegate = self
        detailedView.collectionView?.dataSource = self
    }
    
    private func layout(){
        NSLayoutConstraint.activate([
            detailedView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailedView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            detailedView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            detailedView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor)
        ])
    }
    
    @objc func didTapShare(){
//        to share character info
        print("share button pressed")
    }
}

// MARK: - CollectionView

extension AppCharacterDetailedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.section.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        if indexPath.section == 0 {
            cell.backgroundColor = .systemYellow
        } else if indexPath.section == 1 {
            cell.backgroundColor = .systemRed
        } else {
            cell.backgroundColor = .systemBlue
        }
        return cell
    }
}
