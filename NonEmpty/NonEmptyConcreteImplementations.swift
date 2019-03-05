//
//  NonEmptyConcreteImplementations.swift
//  DomainTests
//
//  Created by Sam.Warner on 8/12/17.
//  Copyright © 2017 Fairfax Digital. All rights reserved.
//

import Foundation

/// A set of collections which enforce the prescence of at least one item in the collection

public struct NonEmptyCollection<C: Collection>: NonEmpty {

    public let contained: C

    init?(collection: C) {
        guard !collection.isEmpty else {
            return nil
        }
        self.contained = collection
    }
}

public struct NonEmptyBidirectionalCollection<C: BidirectionalCollection>: NonEmptyBidirectional {

    public let contained: C

    init?(collection: C) {
        guard !collection.isEmpty else {
            return nil
        }
        self.contained = collection
    }
}

public struct NonEmptyRandomAccessCollection<C: RandomAccessCollection>: NonEmptyRandomAccess {

    public let contained: C

    init?(collection: C) {
        guard !collection.isEmpty else {
            return nil
        }
        self.contained = collection
    }
}

/// Conforming `NonEmpty` Collections to `Collection`

extension NonEmptyCollection: Collection {

    public var startIndex: C.Index { return self.contained.startIndex }
    public var endIndex: C.Index { return self.contained.endIndex }

    public func index(after i: C.Index) -> C.Index { return self.contained.index(after: i) }

    public subscript(position: C.Index) -> C.Element { return self.contained[position] }
    public subscript(bounds: Range<C.Index>) -> C.SubSequence { return self.contained[bounds] }
}

extension NonEmptyBidirectionalCollection: Collection {

    public var startIndex: C.Index { return self.contained.startIndex }
    public var endIndex: C.Index { return self.contained.endIndex }

    public func index(after i: C.Index) -> C.Index { return self.contained.index(after: i) }

    public subscript(position: C.Index) -> C.Element { return self.contained[position] }
    public subscript(bounds: Range<C.Index>) -> C.SubSequence { return self.contained[bounds] }
}

extension NonEmptyRandomAccessCollection: Collection {

    public var indices: C.Indices { return self.contained.indices }

    public var startIndex: C.Index { return self.contained.startIndex }
    public var endIndex: C.Index { return self.contained.endIndex }

    public func index(after i: C.Index) -> C.Index { return self.contained.index(after: i) }

    public subscript(position: C.Index) -> C.Element { return self.contained[position] }
    public subscript(bounds: Range<C.Index>) -> C.SubSequence { return self.contained[bounds] }
}

/// Conforming `NonEmpty` BidirectionalCollections to `BidirectionalCollection`

extension NonEmptyBidirectionalCollection: BidirectionalCollection {

    public func index(before i: C.Index) -> C.Index { return self.contained.index(before: i) }
}

extension NonEmptyRandomAccessCollection: BidirectionalCollection {

    public func index(before i: C.Index) -> C.Index { return self.contained.index(before: i) }
}
