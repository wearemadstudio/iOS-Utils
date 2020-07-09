//
//  MulticastDelegate.swift
//  galt
//
//  Created by Денис Бородавченко on 02.06.2018.
//  Copyright © 2018 GALT. All rights reserved.
//

import Foundation

open class MulticastDelegate<T> {
    
    private class WeakWrapper {
        weak var value: AnyObject?
        
        init(value: AnyObject) {
            self.value = value
        }
    }
    
    private var weakDelegates = [WeakWrapper]()
    
    public init() { }
    
    public func addDelegate(delegate: T) {
        weakDelegates.append(WeakWrapper(value: delegate as AnyObject))
    }
    
    public func removeDelegate(delegate: T) {
        for (index, delegateInArray) in weakDelegates.enumerated().reversed() {
            if delegateInArray.value === (delegate as AnyObject) {
                weakDelegates.remove(at: index)
            }
        }
    }
    
    public func invoke(invocation: (T) -> Void) {
        for (index, delegate) in weakDelegates.enumerated().reversed() {
            if let delegate = delegate.value {
                invocation(delegate as! T)
            } else {
                weakDelegates.remove(at: index)
            }
        }
    }
}

public func += <T: AnyObject> (left: MulticastDelegate<T>, right: T) {
    left.addDelegate(delegate: right)
}

public func -= <T: AnyObject> (left: MulticastDelegate<T>, right: T) {
    left.removeDelegate(delegate: right)
}
