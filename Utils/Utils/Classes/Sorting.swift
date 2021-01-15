//
//  Sorting.swift
//  Utils
//
//  Created by Николай Садчиков on 12.01.2021.
//  Copyright © 2021 wearemad. All rights reserved.
//

import Foundation

public enum SortOrder {
    case ascending
    case descending
}

public struct SortDescriptor<Value> {
    public var comparator: (Value, Value) -> ComparisonResult
    
    public static func keyPath<T: Comparable>(_ keyPath: KeyPath<Value, T>) -> Self {
        Self { rootA, rootB in
            let valueA = rootA[keyPath: keyPath]
            let valueB = rootB[keyPath: keyPath]
            
            guard valueA != valueB else {
                return .orderedSame
            }
            
            return valueA < valueB ? .orderedAscending : .orderedDescending
        }
    }
}

public extension Sequence {
    func sorted(using descriptors: [SortDescriptor<Element>],
                order: SortOrder) -> [Element] {
        sorted { valueA, valueB in
            for descriptor in descriptors {
                let result = descriptor.comparator(valueA, valueB)
                
                switch result {
                case .orderedSame:
                    break
                case .orderedAscending:
                    return order == .ascending
                case .orderedDescending:
                    return order == .descending
                }
            }
            
            return false
        }
    }
    
    func sorted(using descriptors: SortDescriptor<Element>..., order: SortOrder) -> [Element] {
        sorted(using: descriptors, order: order)
    }
}
