//
//  File.swift
//  
//
//  Created by Tyler Madonna on 11/30/19.
//

import Foundation

public struct ObserverToken {

    private let unregisterBlock: () -> Void

    public let id = UUID().uuidString

    public init(_ unregisterBlock: @escaping () -> Void) {
        self.unregisterBlock = unregisterBlock
    }

    public func unregister() {
        unregisterBlock()
    }

}

extension ObserverToken: CustomStringConvertible {

    public var description: String {
        return "ObserverToken(\(self.id))"
    }

}
