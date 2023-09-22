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
    
    private var cellViewModel : [String] = []
    
    private var hasMoreResult: Bool {
        return false
    }
    // MARK: - Init

    init(){
    }
    
    public func fetchLocations(){
        AppService.shared.execute(.listLocationRequests, expecting: String.self) { [weak self] result in
            switch result {
            case .success(let model):
                self?.delegate?.didFetchInitialLocation()
            case .failure(let error):
                break
            }
        }
        let request = AppRequest(endPoint: .location)
    }
    
    
}
