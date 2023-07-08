//
//  CharacterListViewViewModel.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 4.07.2023.
//

import UIKit

protocol AppCharacterListViewModelDelegate: AnyObject {
    func didLoadInitialCharacter()
    func didSelectCharacter(_ character: AppCharacters)  //for going into detailed view
    
}

final class CharacterListViewViewModel:NSObject {
    
    public weak var delegate: AppCharacterListViewModelDelegate?
    
    private var characters: [AppCharacters] = [] {
        didSet {
            for character in characters {
                let viewModel = AppCharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image)
                )
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
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacter()   // it will trigger update view so main thread
                }
               
                
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
            fatalError("Unsupported Cell")
        }
        let viewModel = cellViewModels[indexPath.row]
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        delegate?.didSelectCharacter(character)
        
    }
}
