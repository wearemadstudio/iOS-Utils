//
//  UIView+Extensions.swift
//  Utils
//
//  Created by Николай Садчиков on 28/05/2019.
//  Copyright © 2019 wearemad. All rights reserved.
//

import UIKit

public struct ShimmerAnimationConfig {
    public var colorOne = UIColor(white: 0.1, alpha: 1)
    public var colorTwo = UIColor(white: 0.5, alpha: 1)
    public var fromValue: Any? = [-1.0, -0.5, 0.0]
    public var toValue: Any? = [1.0, 1.5, 2.0]
    public var duration: CFTimeInterval = 0.9
    public var repeatCount: Float = .infinity
    
    public static var shimmerAnimationConfig = ShimmerAnimationConfig()
}

public extension UIView {
    
    // MARK: - Blur
    
    func addBlur(color: UIColor, style: UIBlurEffect.Style = .dark) {
        backgroundColor = UIColor.clear
        
        let blurEffect = UIBlurEffect(style: style)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.bounds
        blurEffectView.contentView.backgroundColor = color
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        insertSubview(blurEffectView, at: 0)
    }
    
    func removeBlur() {
        for subview in self.subviews {
            if subview is UIVisualEffectView {
                subview.removeFromSuperview()
            }
        }
    }
    
    // MARK: - Borders'&'Corners
    
    func roundCorners(radius: CGFloat) {
        layer.masksToBounds = true
        layer.cornerRadius = radius
    }
    
    func circularCorners() {
        roundCorners(radius: bounds.height * 0.5)
    }
    
    func setBorderAndRoundCorners(width: CGFloat, radius: CGFloat, color: UIColor? = nil) {
        layer.borderWidth = width
        layer.borderColor = color?.cgColor ?? UIColor.black.cgColor
        roundCorners(radius: radius)
    }
    
    // MARK: - Constraints'&'Positions
    
    func pin(to view: UIView, leftOffset: CGFloat = 0, rightOffset: CGFloat = 0, topOffset: CGFloat = 0, bottomOffset: CGFloat = 0) {
        self.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            self.leftAnchor.constraint(equalTo: view.leftAnchor, constant: leftOffset),
            self.rightAnchor.constraint(equalTo: view.rightAnchor, constant: rightOffset),
            self.topAnchor.constraint(equalTo: view.topAnchor, constant: topOffset),
            self.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: bottomOffset)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: - Shadow
    
    func setShadow(color: UIColor = .black,  size: CGSize, opacity: Float, radius: CGFloat) {
        clipsToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowRadius = radius
        layer.shadowOffset = size
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
    }
    
    func setShadow(color: UIColor,
                   x: CGFloat = 0,
                   y: CGFloat = 0,
                   blur: CGFloat = 0,
                   spread: CGFloat = 0) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: x, height: y)
        layer.shadowRadius = blur / 2
        if spread == 0 {
            layer.shadowPath = nil
        } else {
            let rect = bounds.insetBy(dx: -spread, dy: -spread)
            layer.shadowPath = UIBezierPath(rect: rect).cgPath
        }
    }
    
    // MARK: - Gradient
    
    func hasLinearGradient(name: String = "GradientLayer") -> Bool {
        return layer.sublayers?.contains { $0.name == name } ?? false
    }
    
    func removeLinearGradient(name: String = "GradientLayer") {
        layer.sublayers?.first(where: { $0.name == name })?.removeFromSuperlayer()
    }
    
    func setLinearGradient(with colors: [UIColor],
                           locations: [NSNumber]? = nil,
                           name: String = "GradientLayer",
                           vertical: Bool = false,
                           invertedAxis: Bool = false) {
        let layer0 = CAGradientLayer()
        layer0.name = name
        layer0.colors = colors.map({ $0.cgColor })
        if let locations = locations {
            layer0.locations = locations
        } else {
            layer0.locations = [0, 0.56, 1]
        }
        layer0.startPoint = vertical ? CGPoint(x: 0.5, y: 0) : CGPoint(x: 0.25, y: 0.5)
        layer0.endPoint = vertical ? CGPoint(x: 0.5, y: 1) : CGPoint(x: 0.75, y: 0.5)
        if invertedAxis {
            let tempPoint = layer0.startPoint
            layer0.startPoint = layer0.endPoint
            layer0.endPoint = tempPoint
        }
        layer0.bounds = frame
        layer0.position = center
        layer0.frame = bounds
        layer.insertSublayer(layer0, below: layer.sublayers?.first)
    }
    
    func addPulseAnimation(fromValue: Double = 1, toValue: Double = 1.1,
                           autoreverses: Bool = true,
                           repeatCount: Float = .greatestFiniteMagnitude,
                           initialVelocity: CGFloat = 0.1,
                           damping: CGFloat = 0,
                           mass: CGFloat = 10,
                           duration: CFTimeInterval? = nil) {
        let key = "pulse"
        layer.removeAnimation(forKey: key)
        
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.fromValue = fromValue
        pulse.toValue = toValue
        pulse.autoreverses = autoreverses
        pulse.repeatCount = repeatCount
        pulse.initialVelocity = initialVelocity
        pulse.damping = damping
        pulse.mass = mass
        pulse.duration = duration ?? pulse.settlingDuration
        
        layer.add(pulse, forKey: key)
    }
    
    // MARK: - Shimmering Animation
    
    func startShimmerAnimation() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = "shimmer"
        
        gradientLayer.frame = bounds
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.colors = [ShimmerAnimationConfig.shimmerAnimationConfig.colorOne.cgColor,
                                ShimmerAnimationConfig.shimmerAnimationConfig.colorTwo.cgColor,
                                ShimmerAnimationConfig.shimmerAnimationConfig.colorOne.cgColor]
        gradientLayer.locations = [0.0, 0.5, 1.0]
        layer.addSublayer(gradientLayer)
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = ShimmerAnimationConfig.shimmerAnimationConfig.fromValue
        animation.toValue = ShimmerAnimationConfig.shimmerAnimationConfig.toValue
        animation.duration = ShimmerAnimationConfig.shimmerAnimationConfig.duration
        animation.repeatCount = ShimmerAnimationConfig.shimmerAnimationConfig.repeatCount
        gradientLayer.add(animation, forKey: animation.keyPath)
    }
    
    func stopShimmerAnimation() {
        layer.sublayers?.removeAll { $0.name == "shimmer" }
    }
    
    func reloadShimmerAnimation() {
        stopShimmerAnimation()
        startShimmerAnimation()
    }
    
    func updateShimmerAnimation(frame: CGRect? = nil) {
        layer.sublayers?.first { $0.name == "shimmer" }?.frame = frame ?? bounds
    }
}
