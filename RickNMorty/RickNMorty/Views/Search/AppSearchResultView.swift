//
//  AppSearchResultView.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 12.10.2023.
//

import UIKit

// Show search results UI(collection or tableView as needed)
final class AppSearchResultView: UIView {
    
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
        addSubviews(tableView)
//        backgroundColor = .red
    }
    
    private func layout(){
        //TableView
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
        tableView.backgroundColor = .yellow
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
            setupTableView()
            
        }
    }
  
    private func setupCollectionView(){
        
    }
    
    private func setupTableView() {
        tableView.isHidden = false
    }
    
    public func configure(with viewModel: AppSearchResultViewModel){
        self.viewModel = viewModel
    }
}
