import XCTest
@testable import SwiftToTen

final class SwiftToTenTests: XCTestCase {
    func testSomeHours() {
        XCTAssertEqual(SwiftToTen.recognizeTime(in: "12:34", calendar: .test), Date(timeIntervalSince1970: 45240))
        XCTAssertEqual(SwiftToTen.recognizeTime(in: "In the middle 12:34 of a string", calendar: .test), Date(timeIntervalSince1970: 45240))

        XCTAssertNil(SwiftToTen.recognizeTime(in: "", calendar: .test))
        XCTAssertNil(SwiftToTen.recognizeTime(in: "Nothing in this string to convert", calendar: .test))
    }

    func testPostMeridiem() {
        // 01:37
        XCTAssertEqual(SwiftToTen.recognizeTime(in: "1:37 am", calendar: .test), Date(timeIntervalSince1970: 5820))
        // 13:37
        XCTAssertEqual(SwiftToTen.recognizeTime(in: "1:37 pm", calendar: .test), Date(timeIntervalSince1970: 49020))
    }

    func testOClock() {
        // 7:00
        XCTAssertEqual(SwiftToTen.recognizeTime(in: "7 o'clock", calendar: .test), Date(timeIntervalSince1970: 25200))
        // 8:00
        XCTAssertEqual(SwiftToTen.recognizeTime(in: "8 o'clock", calendar: .test), Date(timeIntervalSince1970: 28800))
        // 14:00
        XCTAssertEqual(SwiftToTen.recognizeTime(in: "2 o'clock in the afternoon", calendar: .test), Date(timeIntervalSince1970: 50400))
    }

    func testMidnight() {
        // 00:00
        XCTAssertEqual(SwiftToTen.recognizeTime(in: "midnight", calendar: .test), Date(timeIntervalSince1970: 0))

        // 00:00
        XCTAssertEqual(SwiftToTen.recognizeTime(in: "Midnight", calendar: .test), Date(timeIntervalSince1970: 0))
    }

    func testToMidnight() {
        // 23:50
        XCTAssertEqual(SwiftToTen.recognizeTime(in: "10 to midnight", calendar: .test), Date(timeIntervalSince1970: 85800))
    }

    func testPastMidnight() {
        // 00:20
        XCTAssertEqual(SwiftToTen.recognizeTime(in: "20 past midnight", calendar: .test), Date(timeIntervalSince1970: 1200))
    }

    static var allTests = [
        ("testSomeHours", testSomeHours),
        ("testPostMeridiem", testPostMeridiem),
        ("testOClock", testOClock),
        ("testMidnight", testMidnight),
        ("testToMidnight", testToMidnight),
        ("testPastMidnight", testPastMidnight),
    ]
}

extension Calendar {
    static var test: Self {
        var calendar = Self(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0) ?? calendar.timeZone
        return calendar
    }
}
