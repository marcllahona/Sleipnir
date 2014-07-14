//
//  Observable.swift
//  Sleipnir
//
//  Created by Artur Termenji on 6/24/14.
//  Copyright (c) 2014 railsware. All rights reserved.
//

import Foundation

class Observable<T> {
    
    typealias DidSet = (newValue: T) -> ()
    typealias Observer = (post: DidSet)
    
    var observers = Dictionary<String, Observer>()
    
    var observableProperty: [T] {
    didSet {
        notify()
    }
    }
    
    init(value: T) {
        self.observableProperty = [T]()
        self.observableProperty.append(value)
    }
    
    func get() -> T {
        return observableProperty[0]
    }
    
    func update(value: T) {
        self.observableProperty[0] = value
    }
    
    func addObserver(identifier: String, observer: Observer) {
        observers[identifier] = observer
    }
    
    func removeObserver(identifer: String) {
        observers.removeValueForKey(identifer)
    }
    
    // Private
    
    func notify() {
        for (identifier, observer) in observers {
            observer.post(newValue: observableProperty[0])
        }
    }
}