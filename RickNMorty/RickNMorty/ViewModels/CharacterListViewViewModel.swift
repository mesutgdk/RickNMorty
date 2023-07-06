//
//  CharacterListViewViewModel.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 4.07.2023.
//

import UIKit

final class CharacterListViewViewModel:NSObject {
    
    private var characters: [AppCharacters] = [] {
        didSet {
            for character in characters {
                let viewModel = AppCharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image))
                cellViewModels.append(viewModel)
        
            }
        }
    }
    
    private var cellViewModels: [AppCharacterCollectionViewCellViewModel] = []
    
    public func fetchCharacters(){
        AppService.shared.execute(.listCharacterRequests, expecting: AppGetAllCharactersResponse.self) { [weak self] result in
            switch result {
            case .success(let responceModel):
                let results = responceModel.results
                self?.characters = results
                
//                print("Example image url : "+String(model.results.first?.image ?? " No image "))
//                print("Page result count: "+String(model.results.count))
            case .failure(let error):
                print(String(describing: error))
            }
        }

    }
}
extension CharacterListViewViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppCharacterCollectionViewCell.cellidentifier, for: indexPath) as? AppCharacterCollectionViewCell else {
            fatalError("Unspupported Cell")
        }
        let viewModel = AppCharacterCollectionViewCellViewModel(
            characterName: "afraz",
            characterStatus: .alive,
            characterImageUrl: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg")
        )
        
        cell.configure(with: viewModel)
        return cell
    }
}
extension CharacterListViewViewModel:UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width-30)/2
        return CGSize(
            width: width,
            height: width * 1.5)
    }
}
