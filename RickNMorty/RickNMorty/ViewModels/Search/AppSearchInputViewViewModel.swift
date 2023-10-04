//
//  AppSearchInputViewViewModel.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 27.09.2023.
//

import Foundation

final class AppSearchInputViewViewModel {
    
    private let type: AppSearchViewController.Config.`Type`
    
    enum DynamicOption: String{
        case status = "Status"
        case gender = "Gender"
        case locationType = "Location Type"
        
        var querryArgument: String {
            switch self {
            case .status:
                return "status"
            case .gender:
                return "gender"
            case .locationType:
                return "type"
            }
        }
        var choices: [String] {
            switch self {
            case .status:
                return ["Alive","Dead","Unknown"]
            case .gender:
                return ["Male","Female","Genderless","Unknown"]
            case .locationType:
                return ["Cluster","Planet","Microverse"]
            }
        }
    }
    
    init(type: AppSearchViewController.Config.`Type`){
        self.type = type
    }
    // MARK: - Public
    /*
     case character - name | status | gender
     case location  - name
     case episode   - name | type
     */
    public var hasDynamicOptions: Bool {
        switch self.type{
        case .character, .location:
            return true
        case .episode:
            return false
            
        }
    }
    
    public var options: [DynamicOption] {
        switch self.type {
        case .character:
            return [.status, .gender]
        case .episode:
            return []
        case .location:
            return [.locationType]
        }
    }
    
    public var searchPlaceHolderText: String {
        switch self.type {
        case .character:
            return "Character Name"
        case .episode:
            return "Episode Title"
        case .location:
            return "Location Name "
        }
    }

}
