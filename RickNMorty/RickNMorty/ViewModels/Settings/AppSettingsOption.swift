//
//  AppSettingsOption.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 20.09.2023.
//

import UIKit

enum AppSettingsOption: CaseIterable {
    case rateApp
    case contactUs
    case terms
    case privacy
    case apiReference
    case viewCode
    
    var displayTitle: String {
        switch self {
        case .rateApp:
            return "Rate App"
        case .contactUs:
            return "Contact Us"
        case .terms:
            return "Terms of Servise"
        case .privacy:
            return "Privacy"
        case .apiReference:
            return "API Reference"
        case .viewCode:
            return "View App Code"
        }
    }
    
    var icon : UIImage? {
        switch self {
        case .rateApp:
            return UIImage(systemName: "star.square.fill")
        case .contactUs:
            return UIImage(systemName: "paperplane.fill")
        case .terms:
            return UIImage(systemName: "doc.append")
        case .privacy:
            return UIImage(systemName: "lock.trianglebadge.exclamationmark")
        case .apiReference:
            return UIImage(systemName: "list.bullet.clipboard")
        case .viewCode:
            return UIImage(systemName: "folder.badge.gearshape")
        }
    }
    
    var iconColor: UIColor {
        switch self {
        case .rateApp:
            return .systemBlue
        case .contactUs:
            return .systemTeal
        case .terms:
            return .systemPink
        case .privacy:
            return .systemBrown
        case .apiReference:
            return .systemOrange
        case .viewCode:
            return .systemMint
        }
    }
}
