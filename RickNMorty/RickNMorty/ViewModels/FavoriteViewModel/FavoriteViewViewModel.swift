//
//  FavoriteViewModel.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 5.02.2025.
//

import Foundation
import UIKit

protocol FavoriteViewModelDelegate: AnyObject {
    func didLoadInitialCharacter() // to reload
    func didSelectCharacter(_ character: AppCharacter)  //for going into detailed view
}
///  View Model to handle character list view logic
final class FavoriteViewViewModel:NSObject {
    
    public weak var delegate: FavoriteViewModelDelegate?

    private var favoriteCharacters: [AppCharacter] = [] {
        didSet {
//            print("Creating viewModels!")
            for character in favoriteCharacters {
                let viewModel = AppCharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image)
                )
//               tekrar eklenmesinin önüne geçmek için
                if !cellViewModels.contains(viewModel) {
                    
                    cellViewModels.append(viewModel)
                    
                }
            }
        }
    }
    
    private var cellViewModels: [AppCharacterCollectionViewCellViewModel] = []
    
    private var apiInfo: AppGetAllCharactersResponse.Info? = nil
    
    public func retrieveFavoritedCharacters(){
        
        AppFavoriteManager.retriveFavorites { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let favorites):
                self.favoriteCharacters = favorites
                DispatchQueue.main.async {
                    self.delegate?.didLoadInitialCharacter()
                }
            case .failure(let error):
                print("Error while retriving favorites \(error)")
            }
        }
    }
    
    
    
}
// MARK: - CollectionView datasource

extension FavoriteViewViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppCharacterCollectionListViewCell.cellIdentifier, for: indexPath) as? AppCharacterCollectionListViewCell else {
                fatalError("Unsupported Cell")
            }
            let viewModel = cellViewModels[indexPath.row]
            
            cell.configure(with: viewModel)
            return cell
    }
}
// MARK: - Collectionview delegate

extension FavoriteViewViewModel:UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let bounds = collectionView.bounds
        
        
        // list'se
            let width = bounds.width-16
            return CGSize(
                width: width,
                height: UIDevice.isIphone ? 100 : 140)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = favoriteCharacters[indexPath.row]
        delegate?.didSelectCharacter(character)
    }
    
    
}

