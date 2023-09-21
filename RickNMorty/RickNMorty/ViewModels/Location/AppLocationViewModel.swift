//
//  AppLocationViewModel.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 21.09.2023.
//

import Foundation

final class AppLocationViewModel{
    
    private var locations : [AppLocation] = []
    
    private var cellViewModel : [String] = []
    
    private var hasMoreResult: Bool {
        return false
    }
    // MARK: - Init

    init(){
    }
    
    public func fetchLocations(){
        AppService.shared.execute(.listLocationRequests, expecting: String.self) { result in
            switch result {
            case .success(let model):
                break
            case .failure(let failure):
                break
            }
        }
        let request = AppRequest(endPoint: .location)
    }
    
    
}
