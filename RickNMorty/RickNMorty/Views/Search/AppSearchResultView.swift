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
        backgroundColor = .red
    }
    
    private func layout(){
        NSLayoutConstraint.activate([
            
        ])
    }
    
    private func processViewModel(){
        guard let viewModel = viewModel else {
            return
        }
        switch viewModel {
        case .characters(let viewModels):
            break
        case .episodes(let viewModels):
            break
        case .locations(let viewModels):
            break
        }
    }
  
    public func configure(with viewModel: AppSearchResultViewModel){
        self.viewModel = viewModel
    }
}
