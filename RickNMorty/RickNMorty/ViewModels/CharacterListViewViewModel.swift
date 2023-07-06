//
//  CharacterListViewViewModel.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 4.07.2023.
//

import UIKit

final class CharacterListViewViewModel:NSObject {
    
    func fetchCharacters(){
        AppService.shared.execute(.listCharacterRequests, expecting: AppGetAllCharactersResponse.self) { result in
            switch result {
            case .success(let model):
                print("Total: "+String(model.info.count))
                print("Page result count: "+String(model.results.count))
            case .failure(let error):
                print(String(describing: error))
            }
        }

    }
}
extension CharacterListViewViewModel: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .systemRed
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
