//
//  UIView+Utils.swift
//  VKActionSheet
//
//  Created by Viachaslau Kastsechka on 11/11/21.
//

import UIKit

extension UIView {
    
    func round() {
        layer.cornerRadius = bounds.height / 2.0
        layer.masksToBounds = true
    }
    
    func roundTopCorners(radius: Float) {
        clipsToBounds = true
        layer.cornerRadius = CGFloat(radius)
        layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func makeBorder(width: Float, with color: UIColor) {
        layer.borderWidth = CGFloat(width)
        layer.borderColor = color.cgColor
    }
}

