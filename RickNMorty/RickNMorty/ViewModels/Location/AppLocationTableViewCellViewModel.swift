//
//  AppLocationTableViewCellViewModel.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 22.09.2023.
//

import Foundation

struct AppLocationTableViewCellViewModel: Hashable, Equatable{
    
    
    private let location: AppLocation
    
    init(location: AppLocation){
        self.location = location
    }
    
    public var name : String {
        return location.name
    }
    
    public var type : String {
        return "Type: "+location.type
    }
    
    public var deminsion : String {
        return location.dimension
    }
    static func == (lhs: AppLocationTableViewCellViewModel, rhs: AppLocationTableViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(location.id)
        hasher.combine(type)
        hasher.combine(deminsion)
    }
    
}
