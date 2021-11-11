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
}

