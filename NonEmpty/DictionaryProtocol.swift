//
//  DictionaryProtocol.swift
//  Domain
//
//  Created by Sam.Warner on 8/12/17.
//  Copyright © 2017 Fairfax Digital. All rights reserved.
//

import Foundation

/// We need a protocol which defines Swift.Dictionary-like behaviour in order to be able to do things like:
/// - extend types which are generic over Dictionaries, i.e. `extension SomeGenericType where SomeGenericType.GenericArg: DictionaryProtocol`
public protocol DictionaryProtocol: Collection, ExpressibleByDictionaryLiteral where Key: Hashable {

    subscript(key: Key) -> Value? { get set }
    subscript(key: Key, default defaultValue: @autoclosure () -> Value) -> Value { get set }

    func mapValues<T>(_ transform: (Value) throws -> T) rethrows -> [Key: T]
}

extension Dictionary: DictionaryProtocol {}
