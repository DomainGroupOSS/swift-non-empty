//
//  NonEmptyConcreteImplementations.swift
//  DomainTests
//
//  Created by Sam.Warner on 8/12/17.
//  Copyright © 2017 Fairfax Digital. All rights reserved.
//

import Foundation

/// A set of collections which enforce the prescence of at least one item in the collection

struct NonEmptyCollection<C: Collection>: NonEmpty {

    let contained: C

    init?(collection: C) {
        guard !collection.isEmpty else {
            return nil
        }
        self.contained = collection
    }
}

struct NonEmptyBidirectionalCollection<C: BidirectionalCollection>: NonEmptyBidirectional {

    let contained: C

    init?(collection: C) {
        guard !collection.isEmpty else {
            return nil
        }
        self.contained = collection
    }
}

struct NonEmptyRandomAccessCollection<C: RandomAccessCollection>: NonEmptyRandomAccess {

    let contained: C

    init?(collection: C) {
        guard !collection.isEmpty else {
            return nil
        }
        self.contained = collection
    }
}

/// Conforming `NonEmpty` Collections to `Collection`

extension NonEmptyCollection: Collection {

    var startIndex: C.Index { return self.contained.startIndex }
    var endIndex: C.Index { return self.contained.endIndex }

    func index(after i: C.Index) -> C.Index { return self.contained.index(after: i) }

    subscript(position: C.Index) -> C.Element { return self.contained[position] }
    subscript(bounds: Range<C.Index>) -> C.SubSequence { return self.contained[bounds] }
}

extension NonEmptyBidirectionalCollection: Collection {

    var startIndex: C.Index { return self.contained.startIndex }
    var endIndex: C.Index { return self.contained.endIndex }

    func index(after i: C.Index) -> C.Index { return self.contained.index(after: i) }

    subscript(position: C.Index) -> C.Element { return self.contained[position] }
    subscript(bounds: Range<C.Index>) -> C.SubSequence { return self.contained[bounds] }
}

extension NonEmptyRandomAccessCollection: Collection {

    var indices: C.Indices { return self.contained.indices }

    var startIndex: C.Index { return self.contained.startIndex }
    var endIndex: C.Index { return self.contained.endIndex }

    func index(after i: C.Index) -> C.Index { return self.contained.index(after: i) }

    subscript(position: C.Index) -> C.Element { return self.contained[position] }
    subscript(bounds: Range<C.Index>) -> C.SubSequence { return self.contained[bounds] }
}

/// Conforming `NonEmpty` BidirectionalCollections to `BidirectionalCollection`

extension NonEmptyBidirectionalCollection: BidirectionalCollection {

    func index(before i: C.Index) -> C.Index { return self.contained.index(before: i) }
}

extension NonEmptyRandomAccessCollection: BidirectionalCollection {

    func index(before i: C.Index) -> C.Index { return self.contained.index(before: i) }
}
