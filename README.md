# SwiftToTen

[![Swift Unit Tests](https://github.com/renaudjenny/swift-to-ten/actions/workflows/swift.yml/badge.svg)](https://github.com/renaudjenny/swift-to-ten/actions/workflows/swift.yml)

⏰🇬🇧 Recognize British English time and try converting it to `Date`

## Usage

```swift
import SwiftToTen

// Set the Calendar to your convenience
var calendar = Calendar(identifier: .gregorian)
calendar.timeZone = TimeZone(secondsFromGMT: 0) ?? calendar.timeZone

var recognizedTime: Date?

// Classic time with HH:mm format
recognizedTime = SwiftToTen.recognizeTime(in: "It's 12:34", calendar: calendar)
print(recognizedTime) // Optional(1970-01-01 12:34:00 +0000)

// In the afternoon HH:mm pm format
recognizedTime = SwiftToTen.recognizeTime(in: "It's 1:37 pm", calendar: calendar)
print(recognizedTime) // Optional(1970-01-01 13:37:00 +0000)

// With o'clock format
recognizedTime = SwiftToTen.recognizeTime(in: "It's 7 o'clock", calendar: calendar)
print(recognizedTime) // Optional(1970-01-01 07:00:00 +0000)

// With o'clock format in the afternoon
recognizedTime = SwiftToTen.recognizeTime(in: "It's 2 o'clock in the afternoon", calendar: calendar)
print(recognizedTime) // Optional(1970-01-01 14:00:00 +0000)

// Midnight, ... to Midnight and ... past Midnight
recognizedTime = SwiftToTen.recognizeTime(in: "It's midnight", calendar: calendar)
print(recognizedTime) // Optional(1970-01-01 00:00:00 +0000)

recognizedTime = SwiftToTen.recognizeTime(in: "It's quarter to midnight", calendar: calendar)
print(recognizedTime) // Optional(1970-01-01 23:45:00 +0000)

recognizedTime = SwiftToTen.recognizeTime(in: "It's 10 past midnight", calendar: calendar)
print(recognizedTime) // Optional(1970-01-01 00:10:00 +0000)

// If the string doesn't contain a recognizable time, it returns `nil`
recognizedTime = SwiftToTen.recognizeTime(in: "It's show time!", calendar: calendar)
print(recognizedTime) // nil
```

## Installation

### Xcode

You can add SwiftToTen to an Xcode project by adding it as a package dependency.

1. From the **File** menu, select **Swift Packages › Add Package Dependency...**
2. Enter "https://github.com/renaudjenny/swift-to-ten" into the package repository URL test field

### As package dependency

Edit your `Package.swift` to add this library.

```swift
let package = Package(
    ...
    dependencies: [
        .package(url: "https://github.com/renaudjenny/swift-to-ten", from: "1.1.0"),
        ...
    ],
    targets: [
        .target(
            name: "<Your project name>",
            dependencies: [.product(name: "SwiftToTen", package: "swift-to-ten")]
        ),
        ...
    ]
)
```

## App using this library

* [📲 Tell Time UK](https://apps.apple.com/gb/app/tell-time-uk/id1496541173): https://github.com/renaudjenny/telltime
