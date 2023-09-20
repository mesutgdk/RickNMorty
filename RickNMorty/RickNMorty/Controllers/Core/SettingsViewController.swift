//
//  SettingsViewController.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 26.06.2023.
//

import UIKit

class SettingsViewController: UIViewController {
    // Bu sayede loop yaparak model içerisine mapleterek celleri arrayleriz
    private let viewModel = AppSettingsViewViewModel(
        cellViewModel: AppSettingsOption.allCases.compactMap({
            return AppSettingsCellViewModel(type: $0)
        })
    )
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Settings"
        view.backgroundColor = .systemBackground
    }
}
