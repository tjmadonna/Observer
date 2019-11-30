//
//  AnyObservable.swift
//  
//
//  Created by Tyler Madonna on 11/30/19.
//

import Foundation

public final class AnyObservable<T>: Observable {

    private let box: _AnyObservableBase<T>

    public init<Concrete: Observable>(_ concrete: Concrete) where Concrete.T == T {
        box = _AnyObservableBox(concrete)
    }

    public func registerObserver<O>(_ observer: O) -> ObserverToken where O : Observer, O.T == T {
        box.registerObserver(observer)
    }

    public func unregisterObserver<O>(_ observer: O) where O : Observer, O.T == T {
        box.unregisterObserver(observer)
    }

}

private final class _AnyObservableBox<Concrete: Observable>: _AnyObservableBase<Concrete.T> {

    fileprivate let concrete: Concrete

    init(_ concrete: Concrete) {
        self.concrete = concrete
    }

    override func registerObserver<O>(_ observer: O) -> ObserverToken where O : Observer, O.T == T {
        concrete.registerObserver(observer)
    }

    override func unregisterObserver<O>(_ observer: O) where O : Observer, O.T == T {
        concrete.unregisterObserver(observer)
    }

}

private class _AnyObservableBase<T>: Observable {

    init() {
        guard type(of: self) != _AnyObservableBase.self else {
            fatalError("_AnyObservableBase instances cannot be initialized and must be subclassed")
        }
    }

    func registerObserver<O>(_ observer: O) -> ObserverToken where O : Observer, O.T == T {
        fatalError("_AnyObservableBase.registerObserver cannot be called and must be subclasses")
    }

    func unregisterObserver<O>(_ observer: O) where O : Observer, O.T == T {
        fatalError("_AnyObservableBase.unregisterObserver cannot be called and must be subclasses")
    }
    
}
