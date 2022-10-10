# NonEmpty
A small library to allow you to express the non-emptiness of a collection _through its type_.

## Status
This framework is no longer being maintained.

## Background
**Other functional languages get [dependent types](https://en.wikipedia.org/wiki/Dependent_type), why not Swift?**

It's quite common that when decoding json to a network model which contains a list of items, we will check that the list exists _and also that it contains at least one item_. If we don't have the non-empty list, then we don't have a valid model and we throw an error. 

But once you pass that model out of the networking layer, that knowledge of non-emptiness is lost, and you'll find yourself consuming that network model somewhere and either checking again that the list is empty (bad), or force-unwrapping somewhere along the way (worse).

What if, when decoding the model, you could encode _in the model property types_ that your list of items was indeed non-empty?

## How to get it 

### Carthage

```
git "DomainGroupOSS/swift-non-empty" "0.1.1"    
```

### Cocoapods

```
pod "SwiftNonEmpty", "0.1.1" 
```

## Usage

### Before
    
```swift
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
```

### After

```swift    
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
```
