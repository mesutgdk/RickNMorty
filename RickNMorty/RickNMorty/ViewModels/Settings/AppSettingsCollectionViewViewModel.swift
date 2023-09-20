//
//  AppSettingsCollectionViewViewModel.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 20.09.2023.
//


import UIKit

protocol AppSettingsCollectionViewViewModelDelegate: AnyObject {
    func didSelectUrl(_ url: URL)
}

final class AppSettingsCollectionViewViewModel: NSObject{
    
    public weak var delegate: AppSettingsCollectionViewViewModelDelegate?
    
    private var viewModel = AppSettingsViewViewModel(
        cellViewModel: AppSettingsOption.allCases.compactMap({
            return AppSettingsCellViewModel(type: $0) { option in
                print(option.displayTitle)
                
            }
        })
    )
    override init() {
        super.init()
        self.viewModel = .init(
            cellViewModel: AppSettingsOption.allCases.compactMap({
                return AppSettingsCellViewModel(type: $0) { [weak self] option in
                    self?.handleTap(option: option)
                }
            }))
    }
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewModel = viewModel.cellViewModel[indexPath.row]
        viewModel.onTapHandler(viewModel.type)
    }
}
extension AppSettingsCollectionViewViewModel{
    private func handleTap(option: AppSettingsOption){
        
        guard Thread.current.isMainThread else {
            return
        }
        if let url = option.targetURL{
            //open website
//            print(url)
            delegate?.didSelectUrl(url)
            
            
        } else if option == .rateApp {
            //show rating prompt
            print("showing rating prompt")
        }
    }
}
