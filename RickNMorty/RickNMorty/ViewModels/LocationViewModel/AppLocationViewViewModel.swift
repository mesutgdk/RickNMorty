//
//  AppLocationViewModel.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 21.09.2023.
//

import Foundation
protocol AppLocationViewViewModelDelegate:AnyObject {
    func didFetchInitialLocation()
}

final class AppLocationViewViewModel{
    
    weak var delegate: AppLocationViewViewModelDelegate?
    
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
    
    private var hasMoreResult: Bool {
        return false
    }
    
    private var finishPagination: (()-> Void)?
    
    public var isLoadingMoreLocations: Bool = false

    
    public var shouldLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
    
    public private(set) var cellViewModels : [AppLocationTableViewCellViewModel] = []
    
    // MARK: - Init
    
    init(){
    }
    
    public func registerDidFinishPagination(_ block: @escaping () -> Void ) {
        self.finishPagination = block
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
                print(String(describing: error))
                break
            }
        }
    }
    
    /// Paginate if additional locations are needed
    public func fetchAdditionalLocations(){
        // ensure it is false, fetch new characters
        guard !isLoadingMoreLocations else{
            return
        }

        guard let nextUrlString = apiInfo?.next,
              let url = URL(string: nextUrlString) else {
            return
        }
        
        isLoadingMoreLocations = true
        
        guard let request = AppRequest(url: url) else {
            isLoadingMoreLocations = false
            print("Failed to create a request")
            return
        }
        
        AppService.shared.execute(request, expecting: AppGetAllLocationsResponse.self) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            switch result {
            case .success(let responseModel):
//                print("pre-update:\(strongSelf.cellViewModels.count)")
                
                let moreResults = responseModel.results
                let info = responseModel.info
               
                strongSelf.apiInfo = info
//                print(info.next) 

                strongSelf.cellViewModels.append(contentsOf: moreResults.compactMap({
                    return AppLocationTableViewCellViewModel(location: $0)
                }))
                
                DispatchQueue.main.async {
                    strongSelf.isLoadingMoreLocations = false
                    
                    // notify via callback
                    strongSelf.finishPagination?()
                }

            case .failure(let failure):
                print(String(describing: failure))
                self?.isLoadingMoreLocations = false
            }
        }

    }
    
}
