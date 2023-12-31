//
//  AppSearchInputView.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 27.09.2023.
//

import UIKit

protocol AppSearchInputViewDelegate: AnyObject{
    func searchInputViewDidSelectOption(_ inputview: AppSearchInputView, didSelectOption option: AppSearchInputViewViewModel.DynamicOption)
    
    func searchInputViewDidChangeText(_ inputview: AppSearchInputView, didChangeText text: String)
    
    func searchInputViewDidTapSearchEnterButton(_ inputview: AppSearchInputView)


}
// view for top part of search screen with search bar
final class AppSearchInputView: UIView {
    
    weak var delegate : AppSearchInputViewDelegate?

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
    
    private var stackView: UIStackView?
    // MARK: -Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    // MARK: - Private

    private func setup(){
        addSubviews(searchBar)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        
        searchBar.delegate = self
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
        self.stackView = stackView
        for x in 0..<options.count {
            let option = options[x]
            
            let button = createOptionButton(with: option, tag : x)

            stackView.addArrangedSubview(button)
            //            print(option.rawValue)
        }
    }
    
    @objc func didTapButton(_ sender: UIButton){
        guard let options = viewModel?.options else {
            return
        }
        let tag = sender.tag
        let selectedOption = options[tag]
        
        delegate?.searchInputViewDidSelectOption(self, didSelectOption: selectedOption)
//        print("Did tap \(selectedOption.rawValue)")
        
    }
    
    private func createOptionStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 6
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        stackView.backgroundColor = .systemBackground
        addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
            stackView.leftAnchor.constraint(equalTo: leftAnchor),
            stackView.rightAnchor.constraint(equalTo: rightAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        return stackView
    }
    
    private func createOptionButton(with option: AppSearchInputViewViewModel.DynamicOption, tag: Int )-> UIButton{
        let button = UIButton()
        
        button.setAttributedTitle(
            NSAttributedString(
                string:  option.rawValue,
                attributes: [
                    .font:UIFont.systemFont(ofSize: 18,weight: .medium),
                    .foregroundColor: UIColor.label
                ]
            ),
            for: .normal)
        
        button.backgroundColor = .secondarySystemFill
//            button.setTitleColor(.label, for: .normal)
        button.addTarget(self, action: #selector(didTapButton(_:)), for: .touchUpInside)
        
        button.tag = tag
        button.layer.cornerRadius = 6
        
        return button
    }
    
    // MARK: - Public

    public func configure(with viewModel: AppSearchInputViewViewModel){
        searchBar.placeholder = viewModel.searchPlaceHolderText
        
        // toDo: fix height of input view for episode with no option
        self.viewModel = viewModel
    }
    
    public func presentKeyboard(){
        searchBar.becomeFirstResponder()
    }
    
    public func updateTitle(option: AppSearchInputViewViewModel.DynamicOption, value: String ){
        guard let buttons = stackView?.arrangedSubviews as? [UIButton],
              let allOptions = viewModel?.options,
              let index = allOptions.firstIndex(of: option) else {
            return
        }
        
        let button : UIButton = buttons[index]
        button.setAttributedTitle(
            NSAttributedString(
                string: value.uppercased(),
                attributes: [
                    .font:UIFont.systemFont(ofSize: 18,weight: .medium),
                    .foregroundColor: UIColor.link
                    
                ]
            ),
            for: .normal)
    }
}
extension AppSearchInputView: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // Notify delegate of change the text
//        print(searchText)
        delegate?.searchInputViewDidChangeText(self, didChangeText: searchText)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // Execute search
        searchBar.resignFirstResponder() // keyboarddan kurtulalım
        delegate?.searchInputViewDidTapSearchEnterButton(self)
    }
    
   
}
