//
//  Observable.swift
//  
//
//  Created by Tyler Madonna on 11/30/19.
//

import Foundation

public protocol Observable {

    associatedtype T

    func registerObserver<O>(_ observer: O) -> ObserverToken where O: Observer, O.T == T

    func unregisterObserver<O>(_ observer: O) where O: Observer, O.T == T

}
