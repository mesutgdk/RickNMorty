//
//  AppCharacterInfoCollectionViewCellViewModel.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 3.08.2023.
//

import UIKit

final class AppCharacterInfoCollectionViewCellViewModel {
    
    private let type: `Type`
    private let value: String
    
    static let dateFormatter: DateFormatter = { // use static not to create over and over, for performance
        //Format --> 2017-11-04T18:50:21.651Z
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSSZ" //dateformetter fractional seconds problem
        formatter.timeZone = .current
        return formatter
    }()
    
    static let shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    
    
    public var title: String {
        self.type.displayTitle
    }
    
    public var displayValue: String {
        if value.isEmpty {
            return "None"
        }
       
        if let date = Self.dateFormatter.date(from: value), type == .created {
//            let result = Self.shortDateFormatter.string(from: date)
//            print(result)
            return Self.shortDateFormatter.string(from: date)
        }
        return value
    }
    
    public var iconImage: UIImage? {
        return type.iconImage
    }
    
    public var tintColor: UIColor {
        return type.tintColor
    }
    
    enum `Type`:String {
        case status
        case gender
        case type
        case specias
        case origin
        case created
        case location
        case episodeCount
        
        var iconImage: UIImage? {
            switch self {
            case .status:
                return UIImage(systemName: "bell")
            case .gender:
                return UIImage(systemName: "bell")
            case .type:
                return UIImage(systemName: "bell")
            case .specias:
                return UIImage(systemName: "bell")
            case .origin:
                return UIImage(systemName: "bell")
            case .created:
                return UIImage(systemName: "bell")
            case .location:
                return UIImage(systemName: "bell")
            case .episodeCount:
                return UIImage(systemName: "bell")
            }
        }
        
        var tintColor: UIColor {
            switch self {
            case .status:
                return .systemTeal
            case .gender:
                return .systemBlue
            case .type:
                return .systemRed
            case .specias:
                return .systemOrange
            case .origin:
                return .systemIndigo
            case .created:
                return .systemBrown
            case .location:
                return .systemPurple
            case .episodeCount:
                return .systemMint
            }
        }
        
        var displayTitle: String {
            switch self {
            case .status,
                .gender,
                .type,
                .specias,
                .origin,
                .created,
                .location:
                return rawValue.uppercased()
            case .episodeCount:
                return "EPISODE COUNT"
            }
        }
    }
    
    init(type:`Type`, value: String) {
        self.type = type
        self.value = value
    }
}
