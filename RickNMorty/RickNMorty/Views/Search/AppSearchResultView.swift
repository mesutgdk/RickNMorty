//
//  AppSearchResultView.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 12.10.2023.
//

import UIKit

protocol AppSearchResultViewDelegate: AnyObject{
    func appSearchResultViewDidSelectRow(_ resultView: AppSearchResultView, didTapLocationAt: Int)

}
// Show search results UI(collection or tableView as needed)
final class AppSearchResultView: UIView {
    
    weak var delegate: AppSearchResultViewDelegate?
    
    private var viewModel: AppSearchResultViewModel? {
        didSet {
            self.processViewModel()
        }
    }
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.register(AppLocationTableViewCell.self, forCellReuseIdentifier: AppLocationTableViewCell.cellIdentifier)
        table.isHidden = true
        return table
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(AppCharacterCollectionGridViewCell.self, forCellWithReuseIdentifier: AppCharacterCollectionGridViewCell.cellIdentifier)
        collectionView.register(AppEpisodeInfoCollectionViewCell.self, forCellWithReuseIdentifier: AppEpisodeInfoCollectionViewCell.cellIdentifier)
        collectionView.register(AppFooterLoadingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: AppFooterLoadingCollectionReusableView.identifier)
        return collectionView
    } ()
    
    private var locationCellViewModels : [AppLocationTableViewCellViewModel] = []
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        translatesAutoresizingMaskIntoConstraints = false
        isHidden = true
        addSubviews(tableView, collectionView)
        backgroundColor = .systemBackground
    }
    
    private func layout(){
        //TableView
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
        //CollectionView
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leftAnchor.constraint(equalTo: leftAnchor),
            collectionView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    
    private func processViewModel(){
        guard let viewModel = viewModel else {
            return
        }
        switch viewModel {
        case .characters(let viewModels):
            setupCollectionView()
            
        case .episodes(let viewModels):
            setupCollectionView()
            
        case .locations(let viewModels):
            setupTableView(viewModels: viewModels)
            
        }
    }
  
    private func setupCollectionView(){
        self.tableView.isHidden = true
        self.collectionView.isHidden = false
        collectionView.reloadData()
    }
    
    private func setupTableView(viewModels: [AppLocationTableViewCellViewModel]) {
        tableView.isHidden = false
        collectionView.isHidden = true
        tableView.dataSource = self // datasource önce olması lazım
        tableView.delegate = self
        
        self.locationCellViewModels = viewModels
        tableView.reloadData()
    }
    
    public func configure(with viewModel: AppSearchResultViewModel){
        self.viewModel = viewModel
    }
}

extension AppSearchResultView: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationCellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppLocationTableViewCell.cellIdentifier, for: indexPath) as? AppLocationTableViewCell else {
            fatalError("failed to dequeue tableCell")
        }
//        cell.backgroundColor = .systemGray3
        cell.configure(with: locationCellViewModels[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.appSearchResultViewDidSelectRow(self, didTapLocationAt: indexPath.row)
    }
    
}
