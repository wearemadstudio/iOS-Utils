//
//  UIWindow+Extensions.swift
//  Utils
//
//  Created by Николай Садчиков on 07.07.2020.
//  Copyright © 2020 wearemad. All rights reserved.
//

import Foundation

public extension UIWindow {
    
    func topViewController() -> UIViewController? {
        var top = rootViewController
        while true {
            if let presented = top?.presentedViewController {
                top = presented
            } else if let nav = top as? UINavigationController {
                top = nav.visibleViewController
            } else if let tab = top as? UITabBarController {
                top = tab.selectedViewController
            } else {
                break
            }
        }
        return top
    }
}
