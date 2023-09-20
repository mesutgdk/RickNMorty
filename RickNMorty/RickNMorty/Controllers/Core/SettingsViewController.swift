//
//  SettingsViewController.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 26.06.2023.
//
import SafariServices
import UIKit

final class SettingsViewController: UIViewController {
    
    private let settingsView = AppSettingsView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
    }
    
    private func setup(){
        view.addSubview(settingsView)
        title = "Settings"
        view.backgroundColor = .systemBackground
        
        settingsView.delegate = self
        
    }
    
    private func layout(){
        NSLayoutConstraint.activate([
            settingsView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            settingsView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            settingsView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            settingsView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
}
extension SettingsViewController: AppSettingsViewDelegate {
    func appSettingsUrlView(_ appSettingsView: AppSettingsView, didSelectUrl url: URL) {
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
}
