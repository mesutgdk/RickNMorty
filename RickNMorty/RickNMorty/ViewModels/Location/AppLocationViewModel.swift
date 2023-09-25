//
//  AppLocationViewModel.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 21.09.2023.
//

import Foundation
protocol AppLocationViewModelDelegate:AnyObject {
    func didFetchInitialLocation()
}

final class AppLocationViewModel{
    
    weak var delegate: AppLocationViewModelDelegate?
    
    private var locations : [AppLocation] = [] {
        didSet {
            for location in locations {
                let cellViewModel = AppLocationTableViewCellViewModel(location: location)
                if !cellViewModels.contains(cellViewModel){
                    cellViewModels.append(cellViewModel)
                }
            }
        }
    }
    
    //Location response Info
    //Will contain next url if present
    
    private var apiInfo: AppGetAllLocationsResponse.Info?
    
    public private(set) var cellViewModels : [AppLocationTableViewCellViewModel] = []
    
    private var hasMoreResult: Bool {
        return false
    }
    // MARK: - Init
    
    init(){
    }
    
    public func location(at index: Int) -> AppLocation? {
        guard index < locations.count, index >= 0 else {
            return nil
        }
        return self.locations[index]
    }
    
    public func fetchLocations(){
        AppService.shared.execute(
            .listLocationRequests,
            expecting: AppGetAllLocationsResponse.self
        ) { [weak self] result in
            switch result {
            case .success(let model):
                self?.apiInfo = model.info
                self?.locations = model.results
                DispatchQueue.main.async {
                    self?.delegate?.didFetchInitialLocation()
                }
            case .failure(let error):
                break
            }
        }
    }
    
    
}
