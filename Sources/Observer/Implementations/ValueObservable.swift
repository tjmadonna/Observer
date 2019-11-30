//
//  ValueObservable.swift
//  
//
//  Created by Tyler Madonna on 11/30/19.
//

import Foundation

public class ValueObservable<T>: Observable {

    private let queue = DispatchQueue(label: "ValueObservable-\(UUID().uuidString)", attributes: .concurrent)

    private var observers = Set<AnyObserver<T>>()

    private var observersCopy: Set<AnyObserver<T>>? {
        var observersCopy: Set<AnyObserver<T>>? = nil
        queue.sync {
            observersCopy = Set(self.observers)
        }
        return observersCopy
    }

    public func registerObserver<O>(_ observer: O) -> ObserverToken where O : Observer, O.T == T {
        let token = ObserverToken { self.unregisterObserver(observer) }
        queue.async(flags: .barrier) {
            self.observers.insert(AnyObserver(observer))
        }
        return token
    }

    public func unregisterObserver<O>(_ observer: O) where O : Observer, O.T == T {
        queue.async(flags: .barrier) {
            self.observers.remove(AnyObserver(observer))
        }
    }

    public func notifyObserversOfChangedValue(_ value: T) {
        // Copy the set to release the lock as soon as possible
        observersCopy?.forEach { observer in
            observer.onObservableChangedValue(value)
        }
    }

}
