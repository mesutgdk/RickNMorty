//
//  LauncAnimationViewController.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 22.09.2023.
//

import UIKit

protocol AppAnimationViewControllerDelegate: AnyObject{
    func animateComplited()
}

final class AppLaunchAnimationViewController: UIViewController {
    
    weak var delegate : AppAnimationViewControllerDelegate?
    
    private let animationView = AppLaunchAnimationView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        layout()
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("im really dead,a i killed myself")
    }
    
    private func setup(){
        view.addSubview(animationView)
        view.backgroundColor = .systemBackground
        
        animationView.delegate = self
    }
    
    private func layout(){
        NSLayoutConstraint.activate([
            animationView.topAnchor.constraint(equalTo: view.topAnchor),
            animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
extension AppLaunchAnimationViewController: AppAnimationViewDelegate{
    func didFinishAnimating() {
        delegate?.animateComplited()
        
        let vc = TabBarViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
        self.endAppearanceTransition() // to kill himself- animateVc
       
        
       
    }
    
}
