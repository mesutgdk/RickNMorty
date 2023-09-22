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
    
    private var locations : [AppLocation] = []
    
    //Lococation response Info
    //Will contain next url if present
    
    private var apiInfo: AppGetAllLocationsResponse.Info?
    
    private var cellViewModel : [String] = []
    
    private var hasMoreResult: Bool {
        return false
    }
    // MARK: - Init
    
    init(){
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
