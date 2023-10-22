//
//  ViewController.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 26.06.2023.
//

import UIKit


final class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setUpTabs() {
        let characterVC = CharacterViewController ()
        let locationVC = LocationViewController ()
        let episodeVC = EpisodeViewController ()
        let settingsVC = SettingsViewController ()
        
        characterVC.navigationItem.largeTitleDisplayMode = .automatic
        locationVC.navigationItem.largeTitleDisplayMode = .automatic
        episodeVC.navigationItem.largeTitleDisplayMode = .automatic
        settingsVC.navigationItem.largeTitleDisplayMode = .automatic
        
        let navCharVC = UINavigationController(rootViewController: characterVC)
        let navLocVC = UINavigationController(rootViewController: locationVC)
        let navEpiVC = UINavigationController(rootViewController: episodeVC)
        let navSetVC = UINavigationController(rootViewController: settingsVC)
        
        navCharVC.tabBarItem = UITabBarItem(title: "Characters", image: UIImage(systemName: "person.3.fill"), tag: 1)
        navLocVC.tabBarItem = UITabBarItem(title: "Locations", image: UIImage(systemName:"globe"), tag: 2)
        navEpiVC.tabBarItem = UITabBarItem(title: "Episodes", image: UIImage(systemName:"sparkles.tv"), tag: 3)
        navSetVC.tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName:"gearshape.fill"), tag: 4)
        
        for nav in [navCharVC,navLocVC,navEpiVC,navSetVC] {
            nav.navigationBar.prefersLargeTitles = true
        }
        
        setViewControllers([navCharVC,navLocVC,navEpiVC,navSetVC], animated: true)
        
        
    }
}

