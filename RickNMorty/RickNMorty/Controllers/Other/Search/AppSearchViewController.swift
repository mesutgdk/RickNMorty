//
//  AppSearchViewController.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 15.09.2023.
//

import UIKit

// dinamic search option view
// Render results
// Render no result zero state
// Searching / API Calls

final class AppSearchViewController: UIViewController {

    
    /// Configuration for search
    struct Config {
        enum `Type` {
            case character // name | status | gender
            case episode // name
            case location // name | type
            
            var title: String {
                switch self {
                case .character:
                    return "Search Character"
                case .episode:
                    return "Search Episode"
                case .location:
                    return "Search Location"
                }
            }
            
            var endpoint: AppEndpoint {
                switch self{
                case .character:
                    return .character
                case .episode:
                    return .episode
                case .location:
                    return .location
                }
            }
        }
        
        let type : `Type`
    }
    
    private let config: Config
    
    private let searchView : AppSearchView
    
    private let viewModel : AppSearchViewViewModel
    
    // MARK: - Init
    init(config: Config) {
        let viewModel = AppSearchViewViewModel(config: config)
        self.viewModel = viewModel
        self.config = config
        self.searchView = AppSearchView(frame: .zero, viewModel: viewModel)
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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        searchView.presentKeyboard()
    }
    
    private func setup(){
        title = config.type.title
        view.backgroundColor = .systemBackground
        view.addSubview(searchView)
        addSearchButton()
        
        searchView.delegate = self
    }
    
    private func layout(){
        NSLayoutConstraint.activate([
            searchView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            searchView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            searchView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            searchView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
extension AppSearchViewController {
    private func addSearchButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Search",
                                                            style: .done ,
                                                            target: self,
                                                            action: #selector(didTapSearchButton))
       
    }
    
    @objc private func didTapSearchButton(){
        viewModel.executeSearch()

    }
}
// MARK: - AppSearchViewDelegate

extension AppSearchViewController: AppSearchViewDelegate{
    func appSearchView(_ searchView: AppSearchView, didSelectOption option: AppSearchInputViewViewModel.DynamicOption) {
        let vc = AppSearchOptionPickerViewController(option: option) { [weak self] selection in
            DispatchQueue.main.async {
                self?.viewModel.set(value: selection, for: option)
    //            print("Did select \(selection)")
            }

        }
        vc.sheetPresentationController?.detents = [.medium()]
        vc.sheetPresentationController?.prefersGrabberVisible = true
        present(vc, animated: true)
//        print("should take the picker \(option.rawValue)")
    }
}

