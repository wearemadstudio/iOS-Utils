//
//  UIView+Extensions.swift
//  Utils
//
//  Created by Николай Садчиков on 28/05/2019.
//  Copyright © 2019 wearemad. All rights reserved.
//

import UIKit

extension UIView {
    
    public func addBlur(color: UIColor, style: UIBlurEffect.Style = .dark) {
        self.backgroundColor = UIColor.clear
        
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.contentView.backgroundColor = color
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.insertSubview(blurEffectView, at: 0)
    }
    
    public func roundCorners(radius: CGFloat) {
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
    }
    
    public func circularCorners() {
        self.roundCorners(radius: self.bounds.height * 0.5)
    }
    
    public func pin(to view: UIView, leftOffset: CGFloat = 0, rightOffset: CGFloat = 0, topOffset: CGFloat = 0, bottomOffset: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: leftOffset),
            self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: rightOffset),
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: topOffset),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomOffset)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
