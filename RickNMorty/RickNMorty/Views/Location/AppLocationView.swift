//
//  AppLocationView.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 21.09.2023.
//

import UIKit

final class AppLocationView: UIView {
    
    private var viewModel : AppLocationViewModel? {
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
        let table = UITableView()
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
    public func configure(with viewModel:AppLocationViewModel){
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
        cell.textLabel?.text = cellViewModel.name
        return cell
    }
}
extension AppLocationView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
