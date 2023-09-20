//
//  AppSettingsCellViewModel.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 20.09.2023.
//

import UIKit

struct AppSettingsCellViewModel {
    // image & title
    
    public let type : AppSettingsOption
    
    public let onTapHandler: (AppSettingsOption) -> Void
    
    init(type: AppSettingsOption, onTapHandler: @escaping (AppSettingsOption) -> Void) {
        self.type = type
        self.onTapHandler = onTapHandler
    }
    
    // MARK: - Public
    public var  image : UIImage {
        return type.icon ?? UIImage(systemName: "star")!
    }
    public var title: String {
        return type.displayTitle
    }
    public var imageColor: UIColor {
        return type.iconColor
    }

}
