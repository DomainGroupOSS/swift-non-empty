//
//  NonEmpty.swift
//  Domain
//
//  Created by Sam.Warner on 7/12/17.
//  Copyright © 2017 Fairfax Digital. All rights reserved.
//

import Foundation

/// Protocols

protocol NonEmpty: Collection {

    associatedtype Contained: Collection

    var contained: Contained { get }
    var knownFirst: Self.Element { get }
}

protocol NonEmptyBidirectional: NonEmpty, BidirectionalCollection where Contained: BidirectionalCollection {

    var knownLast: Self.Element { get }
}

protocol NonEmptyRandomAccess: NonEmptyBidirectional, RandomAccessCollection where Contained: RandomAccessCollection {}

/// Convenience converters for existing Collection types

extension Collection {

    var nonEmpty: NonEmptyCollection<Self>? { return NonEmptyCollection<Self>(collection: self) }
}

extension BidirectionalCollection {

    var nonEmpty: NonEmptyBidirectionalCollection<Self>? { return NonEmptyBidirectionalCollection<Self>(collection: self) }
}

extension RandomAccessCollection {

    var nonEmpty: NonEmptyRandomAccessCollection<Self>? { return NonEmptyRandomAccessCollection<Self>(collection: self) }
}

// Convenience typealiases for existing concrete Collection types

extension Array {

    typealias NonEmpty = NonEmptyRandomAccessCollection<[Element]>
}

extension String {

    typealias NonEmpty = NonEmptyBidirectionalCollection<String>
}

extension Dictionary {

    typealias NonEmpty = NonEmptyCollection<[Key: Value]>
}

/// Default extensions

extension NonEmpty {

    var knownFirst: Element { return self.first! }
}

extension NonEmptyBidirectional {

    var knownLast: Element { return self.last! }
}
