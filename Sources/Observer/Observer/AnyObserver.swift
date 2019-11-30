//
//  File.swift
//  
//
//  Created by Tyler Madonna on 11/30/19.
//

import Foundation

public final class AnyObserver<T>: Observer {

    private let box: _AnyObserverBase<T>

    public init<Concrete: Observer>(_ concrete: Concrete) where Concrete.T == T {
        box = _AnyObserverBox(concrete)
    }

    public func onObservableChangedValue(_ value: T) {
        box.onObservableChangedValue(value)
    }

    public static func == (lhs: AnyObserver<T>, rhs: AnyObserver<T>) -> Bool {
        return lhs.box == rhs.box
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(box)
    }

}

private final class _AnyObserverBox<Concrete: Observer>: _AnyObserverBase<Concrete.T> {

    fileprivate let concrete: Concrete

    init(_ concrete: Concrete) {
        self.concrete = concrete
    }

    override func onObservableChangedValue(_ value: T) {
        concrete.onObservableChangedValue(value)
    }

    static func == (lhs: _AnyObserverBox<Concrete>, rhs: _AnyObserverBox<Concrete>) -> Bool {
        return lhs.concrete == rhs.concrete
    }

    override func hash(into hasher: inout Hasher) {
        hasher.combine(concrete)
    }

}

private class _AnyObserverBase<T>: Observer {

    init() {
        guard type(of: self) != _AnyObserverBase.self else {
            fatalError("_AnyObserverBase instances cannot be initialized and must be subclassed")
        }
    }

    func onObservableChangedValue(_ value: T) {
        fatalError("_AnyObserverBase.onObservableChangedValue cannot be called and must be subclasses")
    }

    static func == (lhs: _AnyObserverBase<T>, rhs: _AnyObserverBase<T>) -> Bool {
        fatalError("_AnyObserverBase.equate cannot be called and must be subclasses")
    }

    func hash(into hasher: inout Hasher) {
        fatalError("_AnyObserverBase.hash cannot be called and must be subclasses")
    }

}
