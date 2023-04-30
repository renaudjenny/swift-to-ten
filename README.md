# SwiftToTen

[![Swift Unit Tests](https://github.com/renaudjenny/swift-to-ten/actions/workflows/swift.yml/badge.svg)](https://github.com/renaudjenny/swift-to-ten/actions/workflows/swift.yml)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Frenaudjenny%2Fswift-to-ten%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/renaudjenny/swift-to-ten)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Frenaudjenny%2Fswift-to-ten%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/renaudjenny/swift-to-ten)

⏰🇬🇧 Recognize British English time and try converting it to `Date`

This package contains two libraries that converts a British spoken time like `"It's seven o'clock."` to an optional `Date` from **epoch** where you can easily extract hour and minute `DateComponents` if you want.

* `SwiftToTen` The main library and has a static function with this signature: `live(time: String, calendar: Calendar) -> Date?` where you simply providing a time like in the example above, see examples below
* `SwiftToTenDependency` A wrapper around the library above facilitating the integration with [Point-Free Dependencies](https://github.com/pointfreeco/swift-dependencies) library or a project made with The Composable Architecture (TCA).

## Usage

```swift
import SwiftToTen

// Set the Calendar to your convenience
var calendar = Calendar(identifier: .gregorian)
calendar.timeZone = TimeZone(secondsFromGMT: 0) ?? calendar.timeZone

var recognizedTime: Date?

// Classic time with HH:mm format
recognizedTime = SwiftToTen.live(time: "It's 12:34", calendar: calendar)
print(recognizedTime) // Optional(1970-01-01 12:34:00 +0000)

// In the afternoon HH:mm pm format
recognizedTime = SwiftToTen.live(time: "It's 1:37 pm", calendar: calendar)
print(recognizedTime) // Optional(1970-01-01 13:37:00 +0000)

// With o'clock format
recognizedTime = SwiftToTen.live(time: "It's 7 o'clock", calendar: calendar)
print(recognizedTime) // Optional(1970-01-01 07:00:00 +0000)

// With o'clock format in the afternoon
recognizedTime = SwiftToTen.live(time: "It's 2 o'clock in the afternoon", calendar: calendar)
print(recognizedTime) // Optional(1970-01-01 14:00:00 +0000)

// Midnight, ... to Midnight and ... past Midnight
recognizedTime = SwiftToTen.live(time: "It's midnight", calendar: calendar)
print(recognizedTime) // Optional(1970-01-01 00:00:00 +0000)

recognizedTime = SwiftToTen.live(time: "It's quarter to midnight", calendar: calendar)
print(recognizedTime) // Optional(1970-01-01 23:45:00 +0000)

recognizedTime = SwiftToTen.live(time: "It's 10 past midnight", calendar: calendar)
print(recognizedTime) // Optional(1970-01-01 00:10:00 +0000)

// If the string doesn't contain a recognizable time, it returns `nil`
recognizedTime = SwiftToTen.live(time: "It's show time!", calendar: calendar)
print(recognizedTime) // nil
```

## [Point-Free Dependencies](https://github.com/pointfreeco/swift-dependencies) usage

Add `@Dependency(\.recognizeTime) var recognizeTime` in your `Reducer`, you will have access to all functions mentioned above.

### Example

```swift
import ComposableArchitecture
import Foundation
import SwiftToTenDependency

public struct BritishTime: ReducerProtocol {
    public struct State: Equatable {
        public var date: Date?

        public init(date: Date? = nil) {
            self.date = date
        }
    }

    public enum Action: Equatable {
        case utteranceChanged(String)
    }

    @Dependency(\.calendar) var calendar
    @Dependency(\.recognizeTime) var recognizeTime

    public init() {}

    public var body: some ReducerProtocol<State, Action> {
        Reduce { state, action in
            switch action {
            case let .utteranceChanged(utterance):
                state.date = recognizeTime(time: utterance, calendar: calendar)
                return .none
        }
    }
}
```

## Installation

### Xcode

You can add SwiftToTen to an Xcode project by adding it as a package dependency.

1. From the **File** menu, select **Swift Packages › Add Package Dependency...**
2. Enter "https://github.com/renaudjenny/swift-to-ten" into the package repository URL text field
3. Select one of the library that you are interested in. See [above](#swifttoten)

### As package dependency

Edit your `Package.swift` to add this library.

```swift
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/renaudjenny/swift-to-ten", from: "1.2.0"),
        ...
    ],
    targets: [
        .target(
            name: "<Your project name>",
            dependencies: [
                .product(name: "SwiftToTen", package: "swift-to-ten"), // <-- Basic version
                .product(name: "SwiftToTenDependency", package: "swift-to-ten"), // <-- Point-Free Dependencies library wrapper
            ]
        ),
        ...
    ]
)
```

## App using this library

* [📲 Tell Time UK](https://apps.apple.com/gb/app/tell-time-uk/id1496541173): https://github.com/renaudjenny/telltime
