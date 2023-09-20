//
//  AppSettingsCollectionViewViewModel.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 20.09.2023.
//

import UIKit

final class AppSettingsCollectionViewViewModel: NSObject{
    
    private let viewModel = AppSettingsViewViewModel(
        cellViewModel: AppSettingsOption.allCases.compactMap({
            return AppSettingsCellViewModel(type: $0)
        })
    )
}
extension AppSettingsCollectionViewViewModel: UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppSettingsViewCollectionViewCell.cellIdentifier, for: indexPath) as? AppSettingsViewCollectionViewCell else {
            fatalError("Unsupported Cell")
        }
        
        let viewModel = viewModel.cellViewModel[indexPath.row]
        cell.configure(with: viewModel)
       
        return cell
    }
    
    
}
extension AppSettingsCollectionViewViewModel: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = collectionView.bounds
        let width = bounds.width - 30
        return CGSize(
            width: width,
            height: 50)
    }
}
