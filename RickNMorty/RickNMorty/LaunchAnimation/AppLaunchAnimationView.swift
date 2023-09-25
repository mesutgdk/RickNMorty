//
//  LaunchAnimationView.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 22.09.2023.
//

import UIKit

protocol AppAnimationViewDelegate: AnyObject {
    func didFinishAnimating()
}

final class AppLaunchAnimationView: UIView {
    
    weak var delegate : AppAnimationViewDelegate?
    
    private let firstLaunchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: Constants.firstLaunchScreen)
        return imageView
    } ()
    private let secondLaunchImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(named: Constants.secondLaunchScreen)
        imageView.alpha = 0
        return imageView
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
        layout()
        
        animate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setUp(){
        addSubviews(firstLaunchImageView,secondLaunchImageView)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
    }
    private func layout(){
        // firstLaunchImageView
        NSLayoutConstraint.activate([
            firstLaunchImageView.topAnchor.constraint(equalTo: topAnchor),
            firstLaunchImageView.leftAnchor.constraint(equalTo: leftAnchor),
            firstLaunchImageView.rightAnchor.constraint(equalTo: rightAnchor),
            firstLaunchImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        // secondLaunchImageView
        NSLayoutConstraint.activate([
            secondLaunchImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            secondLaunchImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            secondLaunchImageView.widthAnchor.constraint(equalToConstant: 150),
            secondLaunchImageView.heightAnchor.constraint(equalTo: widthAnchor)
        ])
    }
}
extension AppLaunchAnimationView{
    private func animate() {
        //logoImageView
        
        UIView.animate(withDuration: 1.8, delay: 0.3, usingSpringWithDamping: 1.2, initialSpringVelocity: 0.5, options: .curveLinear, animations: { [weak self] in
            self?.firstLaunchImageView.transform = CGAffineTransform(scaleX: 3, y: 3)
            self?.firstLaunchImageView.alpha = 0.0
            
        }) {finished in
            if finished {
                self.delegate?.didFinishAnimating()
                
            }
        }

    }
}
