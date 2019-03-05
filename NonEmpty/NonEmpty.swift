//
//  NonEmpty.swift
//  Domain
//
//  Created by Sam.Warner on 7/12/17.
//  Copyright © 2017 Fairfax Digital. All rights reserved.
//

import Foundation

/// Protocols

public protocol NonEmpty: Collection {

    associatedtype Contained: Collection

    var contained: Contained { get }
    var knownFirst: Self.Element { get }
}

public protocol NonEmptyBidirectional: NonEmpty, BidirectionalCollection where Contained: BidirectionalCollection {

    var knownLast: Self.Element { get }
}

public protocol NonEmptyRandomAccess: NonEmptyBidirectional, RandomAccessCollection where Contained: RandomAccessCollection {}

/// Convenience converters for existing Collection types

public extension Collection {

    var nonEmpty: NonEmptyCollection<Self>? { return NonEmptyCollection<Self>(collection: self) }
}

public extension BidirectionalCollection {

    var nonEmpty: NonEmptyBidirectionalCollection<Self>? { return NonEmptyBidirectionalCollection<Self>(collection: self) }
}

public extension RandomAccessCollection {

    var nonEmpty: NonEmptyRandomAccessCollection<Self>? { return NonEmptyRandomAccessCollection<Self>(collection: self) }
}

// Convenience typealiases for existing concrete Collection types

public extension Array {

    typealias NonEmpty = NonEmptyRandomAccessCollection<[Element]>
}

public extension String {

    typealias NonEmpty = NonEmptyBidirectionalCollection<String>
}

public extension Dictionary {

    typealias NonEmpty = NonEmptyCollection<[Key: Value]>
}

/// Default extensions

public extension NonEmpty {

    var knownFirst: Element { return self.first! }
}

public extension NonEmptyBidirectional {

    var knownLast: Element { return self.last! }
}
