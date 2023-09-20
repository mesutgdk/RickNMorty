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
            return UIImage(systemName: "")
        case .contactUs:
            return UIImage(systemName: "")
        case .terms:
            return UIImage(systemName: "")
        case .privacy:
            return UIImage(systemName: "")
        case .apiReference:
            return UIImage(systemName: "")
        case .viewCode:
            return UIImage(systemName: "")
        }
    }
}
