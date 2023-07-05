//
//  Extensions.swift
//  RickNMorty
//
//  Created by Mesut Gedik on 5.07.2023.
//

import UIKit

extension UIView{
    func addSubviews(_ views: UIView...) {
        views.forEach({
            addSubviews($0)
        })
    }
}
