//
//  AppDelegate.swift
//  NonEmptyExamples
//
//  Created by Sam Warner on 5/3/19.
//  Copyright © 2019 Domain Holdings Ltd. All rights reserved.
//

import UIKit
import Foundation
import NonEmpty

/// This is a toy, intended to compile but not run
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {}

enum Before {}; enum After {}; struct PlaceholderError: Error {}

extension Before {
    
    struct OnlyValidIfPopulatedModel {
        
        let aNonEmptyListOfNonEmptyStrings: [String]
        
        init?(json: [String: Any]) {
            guard
                let aPossibleList = json["list"],
                let aDefiniteListOfStrings = aPossibleList as? [String],
                !aDefiniteListOfStrings.isEmpty,
                !aDefiniteListOfStrings.contains(where: { $0.isEmpty })
            else {
                return nil
            }
            
            self.aNonEmptyListOfNonEmptyStrings = aDefiniteListOfStrings
        }
    }
    
    func doDangerousThings(with model: OnlyValidIfPopulatedModel) throws {
        let lastCharacterOfFirstString = model.aNonEmptyListOfNonEmptyStrings.first!.last!
        print(lastCharacterOfFirstString)
    }
    
    func doSafeThings(with model: OnlyValidIfPopulatedModel) throws {
        guard let firstString = model.aNonEmptyListOfNonEmptyStrings.first else {
            throw PlaceholderError()
        }
        guard let lastCharacterOfFirstString = firstString.last else {
            throw PlaceholderError()
        }
        print(lastCharacterOfFirstString)
    }
}

extension After {
    
    struct OnlyValidIfPopulatedModel {
        
        let aNonEmptyListOfNonEmptyStrings: Array<String.NonEmpty>.NonEmpty
        
        init?(selfDocumenting json: [String: Any]) {
            guard
                let aPossibleList = json["list"],
                let aDefiniteListOfStrings = aPossibleList as? [String]
            else {
                return nil
            }
            
            let aDefiniteListOfNonEmptyStrings = aDefiniteListOfStrings.compactMap({ string in string.nonEmpty })
            guard let aDefinitelyNonEmptyListOfNonEmptyStrings = aDefiniteListOfNonEmptyStrings.nonEmpty else {
                return nil
            }
            
            self.aNonEmptyListOfNonEmptyStrings = aDefinitelyNonEmptyListOfNonEmptyStrings
        }
        
        init?(moreCompact json: [String: Any]) {
            guard let strings = json["list"]
                .flatMap({ $0 as? [String] })?
                .compactMap({ $0.nonEmpty })
                .nonEmpty
            else {
                return nil
            }
            
            self.aNonEmptyListOfNonEmptyStrings = strings
        }
    }
    
    func doSafeThings(with model: OnlyValidIfPopulatedModel) throws {
        let firstString = model.aNonEmptyListOfNonEmptyStrings.knownFirst
        let lastCharacterOfFirstString = firstString.knownLast
        print(lastCharacterOfFirstString)
    }
}
