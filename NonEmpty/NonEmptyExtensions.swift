//
//  NonEmptyExtensions.swift
//  Domain
//
//  Created by Sam.Warner on 8/12/17.
//  Copyright © 2017 Fairfax Digital. All rights reserved.
//

import Foundation

/// Allows a `NonEmpty` to return a `NonEmpty` when mapped over
public extension NonEmpty {

    func map<T>(_ transform: (Self.Element) throws -> T) rethrows -> Array<T>.NonEmpty {
        return try self.map(transform).nonEmpty!
    }
}

/// Allows a `NonEmpty` which contains a `Dictionary` to act like a `Dictionary` itself.
/// Warning: Not exhastive; will need to be extended.
public extension NonEmpty where Contained: DictionaryProtocol {

    subscript(key: Contained.Key) -> Contained.Value? { return self.contained[key] }

    func mapValues<T>(_ transform: (Contained.Value) throws -> T) rethrows -> [Contained.Key: T] { return try self.contained.mapValues(transform) }
}

/// Allows a `NonEmpty` which contains a `String` to act like a `String` itself.
/// Warning: not implemented yet; will need to be extended.
public extension NonEmpty where Contained == String {
}

/// Allows the use of + to concatenate a `NonEmpty` collection with an Array
public extension NonEmpty {

    //swiftlint:disable:next syntactic_sugar
    static func + <T>(lhs: Self, rhs: Array<T>) -> Array<T>.NonEmpty where Element == T {
        return (Array(lhs) + rhs).nonEmpty!
    }
}

/// Allows the use of + to concatenate two `NonEmpty` Arrays
public extension NonEmpty where Contained: RandomAccessCollection {

    static func + <T>(lhs: Self, rhs: Self) -> Array<T>.NonEmpty where Element == T {
        return lhs + Array(rhs)
    }
}
