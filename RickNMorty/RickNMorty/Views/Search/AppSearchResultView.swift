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

// there is a bug when pagination is ended, spinner still turns
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
        collectionView.register(AppCharacterEpisodeCollectionViewCell.self, forCellWithReuseIdentifier: AppCharacterEpisodeCollectionViewCell.cellIdentifier)
        
        // Footer for loading and pagination
        collectionView.register(AppFooterLoadingCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: AppFooterLoadingCollectionReusableView.identifier)
        return collectionView
    } ()
    
    // TableView ViewModels
    private var locationCellViewModels : [AppLocationTableViewCellViewModel] = []
    
    // CollectionView ViewModels
    private var collectionViewCellViewModels: [any Hashable] = []
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
        switch viewModel.results {
        case .characters(let viewModels):
            self.collectionViewCellViewModels = viewModels
            setupCollectionView()
            
            
        case .episodes(let viewModels):
            self.collectionViewCellViewModels = viewModels
            setupCollectionView()
            
        case .locations(let viewModels):
            setupTableView(viewModels: viewModels)
            
        }
    }
  
    private func setupCollectionView(){
        self.tableView.isHidden = true
        self.collectionView.isHidden = false
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = .systemBackground
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
// MARK: - UITableView Delegate and DataSource
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
// MARK: - UICollectionView Delegate and DataSource
extension AppSearchResultView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewCellViewModels.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // Character and Episode
        let currentViewModel = collectionViewCellViewModels[indexPath.row]
        if let currentVM = currentViewModel as? AppCharacterCollectionViewCellViewModel {
            // CharacterCell
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppCharacterCollectionGridViewCell.cellIdentifier, for: indexPath) as? AppCharacterCollectionGridViewCell else {
                fatalError("problem with dequeue")
            }
            cell.configure(with: currentVM)

            return cell
        }
        // EpisodeCell
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppCharacterEpisodeCollectionViewCell.cellIdentifier, for: indexPath) as? AppCharacterEpisodeCollectionViewCell else {
            fatalError("problem with dequeue")
        }
        if let episodeVM = currentViewModel as? AppCharacterEpisodeCollectionViewCellViewModel {
            cell.configure(viewModel: episodeVM)
        }
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // Handle Tap item
//        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let currentViewModel = collectionViewCellViewModels[indexPath.row]
        
        let bounds = collectionView.bounds
        
        if currentViewModel is AppCharacterCollectionViewCellViewModel {
            // character
            let width = (bounds.width - 30) / 2
            return CGSize(
                width: width,
                height: width*1.5
            )
        }
        // Episode
        let width = (bounds.width - 20)
        return CGSize(
            width: width,
            height: 100
        )
    }
    
    // CollectionView Footer
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: AppFooterLoadingCollectionReusableView.identifier,
                for: indexPath
              ) as? AppFooterLoadingCollectionReusableView else {
            fatalError("Unsupported")
        }
        
        if let viewModel = viewModel, viewModel.shouldLoadMoreIndicator {
            footer.startAnimating()
        }
        
        return footer
    }
    /// resize the footer
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard let viewModel = viewModel,
            viewModel.shouldLoadMoreIndicator else {
            return .zero
        }
        return CGSize(width: collectionView.frame.width, height: 100)
    }
}
// MARK: - ScrollViewDelegate, Pagination for TableView

extension AppSearchResultView: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if !locationCellViewModels.isEmpty {
            handleLocationSearchPagination(scrollView: scrollView)
        } else {
            // collectionView
            handleCharacterOrEpisodeSearchPagination(scrollView: scrollView)
        }
    }
    
    private func handleLocationSearchPagination(scrollView: UIScrollView){
            guard let viewModel = viewModel,
                  !locationCellViewModels.isEmpty,
                  viewModel.shouldLoadMoreIndicator,
                  !viewModel.isLoadingMoreResults
            else {
                return
            }
            /*
             offset scrollview'in y uç noktası
             if statument: gives us that the edge of the scrollview and updates the page
             -100 is the size of footer's y
              we dicard to fetch n times with using isLoadingMoreChar in fetchAdCh, after using isLo it works only one times
            */
            // timer is for the problem that offset detects top
            Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] tmr in
                let offset = scrollView.contentOffset.y
                let totalContentHeight = scrollView.contentSize.height
                let totalScrollViewFixedHeight = scrollView.frame.size.height

                if offset >= (totalContentHeight - totalScrollViewFixedHeight - 100) {
                    DispatchQueue.main.async {
                        self?.showLoadingIndicator()
                    }
                    viewModel.fetchAdditionalSearchPage{ [weak self] newResults in  // to pass write newresult near köşeli parantez
                        // Refresh TableView
                        self?.tableView.tableFooterView = nil
                        self?.locationCellViewModels = newResults
                        self?.tableView.reloadData()
                    }

                }
                tmr.invalidate()
            }
    }
    
    private func handleCharacterOrEpisodeSearchPagination(scrollView: UIScrollView) {
        
    }
    
    private func showLoadingIndicator() {
        let footer = AppTableLoadingFooterView()
//        footer.backgroundColor = .red
        footer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: 100)
        tableView.tableFooterView = footer
    }
}

