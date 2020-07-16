//
//  UIView+Shimmering.swift
//  EatUpAll
//
//  Created by Cory Kim on 2020/07/16.
//  Copyright © 2020 team rocket. All rights reserved.
//

import UIKit

extension UIView {
    func startShimmering() {

        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor.clear.cgColor,
            UIColor.clear.cgColor,
            UIColor(white: 1.0, alpha: 0.7).cgColor,
            UIColor.clear.cgColor,
            UIColor.clear.cgColor]
        gradientLayer.frame = CGRect(
            x: -frame.width,
            y: -frame.height,
            width: frame.width * 3,
            height: frame.height * 3)
        gradientLayer.locations = [0, 0.2, 0.5, 0.8, 1]
        
        self.layer.mask = gradientLayer
        
        let animation = CABasicAnimation(keyPath: "transform.translation.x")
        animation.duration = 0.2
        animation.fromValue = -self.frame.width / 2
        animation.toValue = self.frame.width / 2
        animation.repeatCount = Float.infinity
        
        let angle = 45 * CGFloat.pi / 180
        gradientLayer.transform = CATransform3DMakeRotation(angle, 0, 0, 1)
        gradientLayer.add(animation, forKey: "shimmeringKey")
    }
    
    func stopShimmering() {
        layer.mask = nil
    }
}
