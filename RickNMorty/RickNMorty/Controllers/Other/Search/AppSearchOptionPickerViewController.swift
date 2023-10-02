//
//  AppSearchOptionPickerViewController.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 2.10.2023.
//

import UIKit

final class AppSearchOptionPickerViewController: UIViewController {

    private let option : AppSearchInputViewViewModel.DynamicOption
    
    private let tableView : UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    } ()
    // MARK: - Init

    init(option: AppSearchInputViewViewModel.DynamicOption){
        self.option = option
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
        setupTableView()
    }
    
    private func setup(){
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        
    }
    private func layout(){
        //TableView
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupTableView(){
        tableView.dataSource = self
        tableView.delegate = self
    }
}
// MARK: - TableViewDataSource and Delegate

extension AppSearchOptionPickerViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return option.choices.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let choice = option.choices[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = choice.uppercased()
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
