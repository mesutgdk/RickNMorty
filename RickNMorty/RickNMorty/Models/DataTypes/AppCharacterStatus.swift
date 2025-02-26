//
//  CharacterStatus.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 27.06.2023.
//

import UIKit

enum AppCharacterStatus: String, Codable, Equatable {
    // 'Alive, 'Dead', or 'unknown'
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
    
    var text: String {
        switch self {
        case .alive, .dead:
            return rawValue
        case .unknown:
            return "Unknown"
        }
    }
    var textColor: UIColor {
        switch self {
        case .alive:
            return .systemGreen
        case .dead:
            return .systemRed
        case .unknown:
            return .systemGray
        }
   
    }
}
