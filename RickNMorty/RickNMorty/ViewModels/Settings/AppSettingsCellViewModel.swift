//
//  AppSettingsCellViewModel.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 20.09.2023.
//

import UIKit

struct AppSettingsCellViewModel {
    // image & title
    
    private let type : AppSettingsOption
    
    init( type: AppSettingsOption) {
        self.type = type
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
