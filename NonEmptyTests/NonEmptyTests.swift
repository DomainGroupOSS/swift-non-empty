//
//  NonEmptyTests.swift
//  Tests
//
//  Created by Sam.Warner on 8/12/17.
//  Copyright © 2017 Fairfax Digital. All rights reserved.
//

import Foundation
@testable import NonEmpty

// We only care if these compile, no runtime tests required

let a: Array<String>.NonEmpty = {
    let array = ["a", "b", "c", "d", "e", "f", "g"]

    let a = array.nonEmpty!
    let b = a.first
    let c = a.knownFirst
    let d = a.compactMap { _ in 1 }
    let e = a.joined(separator: ",")
    let f = a.reversed()
    let g = a.last
    let h = a.firstIndex(of: "a")
    let i = a.lazy
    let j = a.index(before: 2)
    let k = a.isEmpty
    let l = a.count
    let m = a.makeIterator()
    let n = a.prefix(upTo: 2)
    let o = a.suffix(from: 0)
    let p = a.prefix(through: 2)
    let q = a.index(0, offsetBy: 2, limitedBy: 2)
    let r = a.distance(from: 0, to: 2)
    let s = a[2]
    let t = a.filter { $0 == "a" }
    let u = a.reduce("") { $0 + $1 }
    let v = a.enumerated()
    return a
}()

let b: String.NonEmpty = {
    let string = "I've seen things you people wouldn't believe"

    let a = string.nonEmpty!
    let b = a.first
    let c = a.knownFirst
    let d = a.compactMap { _ in 1 }
    let f = a.reversed()
    let g = a.last
    let h = a.firstIndex(of: "a")
    let i = a.lazy
    let j = a.index(before: a.endIndex)
    let k = a.isEmpty
    let l = a.count
    let m = a.makeIterator()
    let n = a.prefix(upTo: a.endIndex)
    let o = a.suffix(from: a.startIndex)
    let p = a.prefix(through: a.startIndex)
    let q = a.index(a.startIndex, offsetBy: 2, limitedBy: a.endIndex)
    let r = a.distance(from: a.startIndex, to: a.endIndex)
    let t = a.filter { $0 == "a" }
    let u = a.reduce("") { $0 + "\($1)" }
    let v = a.enumerated()
    let w = a + "suffix"
    return a
}()

let c: Dictionary<Int, String>.NonEmpty = {
    let dict = [1: "a", 2: "b", 3: "c", 4: "d", 5: "e"]

    let a = dict.nonEmpty!
    let b = a.first
    let c = a.knownFirst
    let d = a.compactMap { _ in 1 }
    let f = a.reversed()
    let i = a.lazy
    let k = a.isEmpty
    let l = a.count
    let m = a.makeIterator()
    let s = a[2]
    let t = a.filter { $1 == "a" }
    let u = a.reduce("") { $0 + $1.value }
    let v = a.enumerated()
    return a
}()
