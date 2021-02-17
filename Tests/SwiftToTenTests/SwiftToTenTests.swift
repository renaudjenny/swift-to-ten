import XCTest
@testable import SwiftToTen

final class SwiftToTenTests: XCTestCase {
    func testSomeHours() {
        XCTAssertEqual(SwiftToTen.recognizeTime(in: "12:34", calendar: .test), Date(timeIntervalSince1970: 45240))
        XCTAssertEqual(SwiftToTen.recognizeTime(in: "In the middle 12:34 of a string", calendar: .test), Date(timeIntervalSince1970: 45240))

        XCTAssertNil(SwiftToTen.recognizeTime(in: "", calendar: .test))
        XCTAssertNil(SwiftToTen.recognizeTime(in: "Nothing in this string to convert", calendar: .test))
    }

    static var allTests = [
        ("testSomeHours", testSomeHours),
    ]
}

extension Calendar {
    static var test: Self {
        var calendar = Self(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0) ?? calendar.timeZone
        return calendar
    }
}
