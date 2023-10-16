//
//  AppLocationView.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 21.09.2023.
//

import UIKit

protocol AppLocationViewDelegate: AnyObject{
    func selectTheRow(_ locaitonView: AppLocationView, didSelect location: AppLocation)
}

final class AppLocationView: UIView {
    
    weak var delegate: AppLocationViewDelegate?
    
    private var isLoadingMoreLocations: Bool = false
    
    private var viewModel : AppLocationViewViewModel? {
        didSet {
            spinner.stopAnimating()
            tableView.isHidden = false
            tableView.reloadData()
            UIView.animate(withDuration: 0.3) {
                self.tableView.alpha = 1
            }
        }
    }
    
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.translatesAutoresizingMaskIntoConstraints = false
        table.isHidden = true
        table.alpha = 0
        table.register(AppLocationTableViewCell.self, forCellReuseIdentifier: AppLocationTableViewCell.cellIdentifier)
        return table
    } ()
    
    private let spinner : UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    } ()
    // MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
        configureTableView()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        addSubviews(tableView,spinner)
        spinner.startAnimating()
    }
    private func layout(){
        // spinner
        NSLayoutConstraint.activate([
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.widthAnchor.constraint(equalTo: spinner.heightAnchor)
        ])
        // TableView
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leftAnchor.constraint(equalTo: leftAnchor),
            tableView.rightAnchor.constraint(equalTo: rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    private func configureTableView(){
        tableView.dataSource = self
        tableView.delegate = self
    }
    public func configure(with viewModel:AppLocationViewViewModel){
        self.viewModel = viewModel
    }
}
extension AppLocationView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cellViewModels.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellViewModels = viewModel?.cellViewModels else {
            fatalError("CellViewModel has no ViewModel")
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AppLocationTableViewCell.cellIdentifier, for: indexPath) as? AppLocationTableViewCell
        else {
            fatalError()
        }
        let cellViewModel = cellViewModels[indexPath.row]
        cell.configure(with: cellViewModel)
        return cell
    }
}
extension AppLocationView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        guard let locationViewModel = viewModel?.location(at: indexPath.row) else {
            return
        }
        delegate?.selectTheRow(self, didSelect: locationViewModel)
    }
}
extension AppLocationView: UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        guard let viewModel = viewModel,
              !viewModel.cellViewModels.isEmpty,
              viewModel.shouldLoadMoreIndicator,
              !isLoadingMoreLocations,
              let nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString) else {
            return
        }
        /*
         offset scrollview'in y uç noktası
         if statument: gives us that the edge of the scrollview and updates the page
         -120 is the size of footer's y
          we dicard to fetch n times with using isLoadingMoreChar in fetchAdCh, after using isLo it works only one times
        */
        // timer is for the problem that offset detects top
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] tmr in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height

            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
                self?.fetchAdditionalLocations(url:url)
            }
            tmr.invalidate()
        }
    }
    
    /// Paginate if additional locations are needed
    public func fetchAdditionalLocations(url:URL){
        // ensure it is false, fetch new characters
        guard !isLoadingMoreLocations else{
            return
        }

        isLoadingMoreEpisodes = true
        
        guard let request = AppRequest(url: url) else {
            isLoadingMoreEpisodes = false
            print("Failed to create a request")
            return
        }
        
        AppService.shared.execute(request, expecting: AppGetAllEpisodesResponse.self) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let responseModel):
//                print("pre-update:\(strongSelf.cellViewModels.count)")
                
                let moreResults = responseModel.results
                let info = responseModel.info
                strongSelf.apiInfo = info
             
                let originalCount = strongSelf.episodes.count
                let newCount  = moreResults.count
                let totalCount = originalCount + newCount
                let startingIndex = totalCount - newCount
                
                let indexPathsToAdd: [IndexPath] = Array(startingIndex..<(startingIndex+newCount)).compactMap {
                    return IndexPath(row: $0, section: 0)
                }

                strongSelf.episodes.append(contentsOf: moreResults)
                
                
                DispatchQueue.main.async {

                    strongSelf.delegate?.didLoadMoreEpisodes(with: indexPathsToAdd)
                    strongSelf.isLoadingMoreEpisodes = false

                }

            case .failure(let failure):
                print(String(describing: failure))
                strongSelf.isLoadingMoreEpisodes = false
            }
        }

    }
}
