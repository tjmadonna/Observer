//
//  Observer.swift
//
//
//  Created by Tyler Madonna on 11/30/19.
//

public protocol Observer: Hashable {

    associatedtype T

    func onObservableChangedValue(_ value: T)

}
