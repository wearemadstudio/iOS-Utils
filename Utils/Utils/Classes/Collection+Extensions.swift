//
//  Collection+Extensions.swift
//  Utils
//
//  Created by Николай Садчиков on 07.07.2020.
//  Copyright © 2020 wearemad. All rights reserved.
//

import Foundation

extension Collection {
    
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
