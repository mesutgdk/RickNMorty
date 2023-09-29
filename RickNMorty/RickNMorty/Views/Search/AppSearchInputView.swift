//
//  AppSearchInputView.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 27.09.2023.
//

import UIKit

final class AppSearchInputView: UIView {

    private let searchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.placeholder = "Search"
        
        return searchBar
    }()
    
    private var viewModel : AppSearchInputViewViewModel?{
        didSet{
            guard let viewModel = viewModel, viewModel.hasDynamicOptions else {
                return
            }
            let options = viewModel.options
            createOptionSelectionView(options: options)
        }
    }
    
    // MARK: -Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setup(){
        addSubviews(searchBar)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .secondarySystemBackground
    }
    
    private func layout(){
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            searchBar.leftAnchor.constraint(equalTo: leftAnchor),
            searchBar.rightAnchor.constraint(equalTo: rightAnchor),
            searchBar.heightAnchor.constraint(equalToConstant: 55)
        ])
        
    }
    
    private func createOptionSelectionView(options: [AppSearchInputViewViewModel.DynamicOption]){

        let stackView = createOptionStackView()
        
        for x in 0..<options.count {
            let option = options[x]
            let button = UIButton()
            button.setTitle(option.rawValue, for: .normal)
            button.backgroundColor = .systemYellow
            button.setTitleColor(.label, for: .normal)
            button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
            
            stackView.addArrangedSubview(button)
//            print(option.rawValue)
        }
    }
    
    @objc func didTapButton(_ sender: UIButton){
        guard let viewModel = viewModel?.options else {
            return
        }
        
    }
    
    private func createOptionStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.backgroundColor = .systemPink
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        return stackView
    }
    
    public func configure(with viewModel: AppSearchInputViewViewModel){
        searchBar.placeholder = viewModel.searchPlaceHolderText
        // toDo: fix height of input view for episode with no option
        self.viewModel = viewModel
    }
    
    public func presentKeyboard(){
        searchBar.becomeFirstResponder()
    }
}