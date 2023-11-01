//
//  AppSearchView.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 26.09.2023.
//

import UIKit

protocol AppSearchViewDelegate: AnyObject{
    func appSearchView(_ searchView: AppSearchView, didSelectOption option: AppSearchInputViewViewModel.DynamicOption)
    
    func appSearchViewLocation(_ searchView: AppSearchView, didSelectLocation location: AppLocation)
    func appSearchViewCharacter(_ searchView: AppSearchView, didSelectCharacter Character: AppCharacter)
    func appSearchViewEpisode(_ searchView: AppSearchView, didSelectEpisode Episode: AppEpisode)

}

final class AppSearchView: UIView {
    
    weak var delegate : AppSearchViewDelegate?
    
    private let viewModel: AppSearchViewViewModel
    
    // MARK: - Subviews
    
    // MARK: - SearchInPutView(bar, selection buttons)
    private let searchInputView = AppSearchInputView()
    
    // MARK: - No result View
    private let noResultView = AppNoSearchResultView()
    
    // MARK: - Result collectionView
    
    private let resultView = AppSearchResultView()
    // MARK: - Init
    
    init(frame: CGRect, viewModel: AppSearchViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        
        setup()
        layout()
        
        setupHandlers()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup(){
        addSubviews(resultView, noResultView, searchInputView)
        backgroundColor = .systemBackground
        translatesAutoresizingMaskIntoConstraints = false
        noResultView.translatesAutoresizingMaskIntoConstraints = false
        searchInputView.translatesAutoresizingMaskIntoConstraints = false
        
        searchInputView.configure(with: AppSearchInputViewViewModel(type: viewModel.config.type))
        
        //Delegates
        searchInputView.delegate = self
        resultView.delegate = self
        
    }
    
    private func layout (){
        // inputView
        NSLayoutConstraint.activate([
            searchInputView.topAnchor.constraint(equalTo: topAnchor),
            searchInputView.leftAnchor.constraint(equalTo: leftAnchor,constant: 5),
            searchInputView.rightAnchor.constraint(equalTo: rightAnchor,constant: -5),
            searchInputView.heightAnchor.constraint(equalToConstant: viewModel.config.type == .episode ? 55 : 110)
        ])
        // noResultView
        NSLayoutConstraint.activate([
            noResultView.centerXAnchor.constraint(equalTo:centerXAnchor),
            noResultView.centerYAnchor.constraint(equalTo: centerYAnchor),
            noResultView.widthAnchor.constraint(equalToConstant: 170),
            noResultView.heightAnchor.constraint(equalToConstant: 170)
        ])
        // resultView
        NSLayoutConstraint.activate([
            resultView.leadingAnchor.constraint(equalTo: leadingAnchor),
            resultView.trailingAnchor.constraint(equalTo: trailingAnchor),
            resultView.bottomAnchor.constraint(equalTo: bottomAnchor),
            resultView.topAnchor.constraint(equalTo: searchInputView.bottomAnchor)
        ])
    }
    
    private func setupHandlers(){
        viewModel.registerOptionChangeBlock{ tuple in
            // tuple : Option | newValue
            //            print(String(describing: tuple))
            self.searchInputView.updateTitle(option: tuple.0, value: tuple.1)
        }
        
        viewModel.registerSearchResultHandler { [weak self] result in
//            print(results)
            DispatchQueue.main.async {
                self?.resultView.configure(with: result)
                self?.noResultView.isHidden = true
                self?.resultView.isHidden = false
            }
        }
        
        viewModel.registerNoResultsHandler { [weak self] in
            DispatchQueue.main.async {
                self?.noResultView.isHidden = false
                self?.resultView.isHidden = true
            }
        }
        
    }
    func presentKeyboard() {
        searchInputView.presentKeyboard()
    }
}
// MARK: - CollectionView Delegate and DataSource
extension AppSearchView: UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
}
// MARK: - AppSearchInputViewDelegate
extension AppSearchView: AppSearchInputViewDelegate{
    
    func searchInputViewDidSelectOption(_ interview: AppSearchInputView, didSelectOption option: AppSearchInputViewViewModel.DynamicOption) {
        delegate?.appSearchView(self, didSelectOption: option)
    }
    
    func searchInputViewDidChangeText(_ inputview: AppSearchInputView, didChangeText text: String) {
        viewModel.set(query: text)
    }
    func searchInputViewDidTapSearchEnterButton(_ inputview: AppSearchInputView) {
        viewModel.executeSearch()
    }
}

// MARK: - AppSearchResultViewDelegate
extension AppSearchView :AppSearchResultViewDelegate {
    
    func appSearchResultViewDidSelectRow(_ resultView: AppSearchResultView, didTapLocationAt index: Int) {
        guard let locationModel = viewModel.locationSearchResult(at: index) else {
            return
        }
        print("Location tapped \(locationModel)")
        delegate?.appSearchViewLocation(self, didSelectLocation: locationModel)
    }
    
    func appSearchResultViewDidSelectRow(_ resultView: AppSearchResultView, didTapCharacterAt index: Int) {
        guard let characterModel = viewModel.characterSearchResult(at: index) else {
            return
        }
        print("character tapped \(characterModel)")
        delegate?.appSearchViewCharacter(self, didSelectCharacter: characterModel)
    }
    
    func appSearchResultViewDidSelectRow(_ resultView: AppSearchResultView, didTapEpisodeAt index: Int) {
        guard let episodeModel = viewModel.episodeSearchResult(at: index) else {
            return
        }
        print("episode tapped \(episodeModel)")
        delegate?.appSearchViewEpisode(self, didSelectEpisode: episodeModel)
    }
    
}


