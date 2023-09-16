//
//  AppEpisodeDetailView.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 13.09.2023.
//

import UIKit

final class AppEpisodeDetailView: UIView {
    
    private var viewModel: AppEpisodeListViewViewModel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setUp(){
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .yellow
    }
    
    private func layout(){
        
    }
    
    func configure(with viewModel:AppEpisodeDetailViewViewModel){
        
    }
}
