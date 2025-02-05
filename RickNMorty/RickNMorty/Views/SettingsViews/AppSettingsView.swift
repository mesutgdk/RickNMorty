//
//  AppSettingsView.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 20.09.2023.
//

import UIKit

protocol AppSettingsViewDelegate: AnyObject {
    func appSettingsUrlView(_ appSettingsView: AppSettingsView, didSelectUrl url: URL)
    func appSettingsCallRateApp(_ appSettingsView: AppSettingsView, callRateApp bool: Bool)
}

final class AppSettingsView: UIView {
    
    
    public weak var delegate: AppSettingsViewDelegate?
    
    // Bu sayede loop yaparak model içerisine mapleterek celleri arrayleriz
    
    private let collectionViewModel = AppSettingsCollectionViewViewModel()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(AppSettingsViewCollectionViewCell.self, forCellWithReuseIdentifier: AppSettingsViewCollectionViewCell.cellIdentifier)
        return collectionView
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
        layout()
        
        collectionViewModel.delegate = self // viewmodelde taplanan buraya gelmeli
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp(){
        addSubview(collectionView)
        translatesAutoresizingMaskIntoConstraints = false
        setupCollectionView()
    }
    private func layout(){
        // collectionView
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    private func setupCollectionView(){
        collectionView.dataSource = collectionViewModel
        collectionView.delegate = collectionViewModel
        
    }
}

extension AppSettingsView: AppSettingsCollectionViewViewModelDelegate{
    func didSelectUrl(_ url: URL) {
        delegate?.appSettingsUrlView(self, didSelectUrl: url)
    }
    func callRateApp(_ callIt: Bool) {
        delegate?.appSettingsCallRateApp(self, callRateApp: callIt)
    }
    
}
