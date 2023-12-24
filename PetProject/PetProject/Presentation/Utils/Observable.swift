//
//  Observable.swift
//  PetProject
//
//  Created by Andrew Sagatelov on 19.12.2023.
//

import Foundation

class Observable<Value> {
    
    struct Observer<Class> {
        weak var observer: AnyObject?
        var block: (Value) -> Void
    }
    
    var observers = [Observer<Value>]()
    
    var value: Value {
        didSet {
           updateObserver()
        }
    }
    
    init(_ value: Value) {
        self.value = value
    }
    
    
    
    func observe(on observer: AnyObject, observerBlock: @escaping (Value) -> Void) {
        observers.append(Observer(observer: observer, block: observerBlock))
        observerBlock(self.value)
    }
    
    func remove(observer: AnyObject) {
       observers = observers.filter { $0.observer !== observer }
    }
    

    func updateObserver() {
        for observer in observers {
            observer.block(self.value)
        }
        
    }
}
