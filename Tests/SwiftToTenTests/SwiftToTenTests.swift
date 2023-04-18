import XCTest
@testable import SwiftToTen

final class SwiftToTenTests: XCTestCase {
    func testSomeHours() {
        XCTAssertEqual(
            SwiftToTen.live(time: "12:34", calendar: .test),
            Date(timeIntervalSince1970: 45240)
        )
        XCTAssertEqual(
            SwiftToTen.live(time: "In the middle 12:34 of a string", calendar: .test),
            Date(timeIntervalSince1970: 45240)
        )

        XCTAssertNil(SwiftToTen.live(time: "", calendar: .test))
        XCTAssertNil(SwiftToTen.live(time: "Nothing in this string to convert", calendar: .test))
    }

    func testPostMeridiem() {
        // 01:37
        XCTAssertEqual(
            SwiftToTen.live(time: "1:37 am", calendar: .test),
            Date(timeIntervalSince1970: 5820)
        )
        // 13:37
        XCTAssertEqual(
            SwiftToTen.live(time: "1:37 pm", calendar: .test),
            Date(timeIntervalSince1970: 49020)
        )
    }

    func testOClock() {
        // 7:00
        XCTAssertEqual(
            SwiftToTen.live(time: "7 o'clock", calendar: .test),
            Date(timeIntervalSince1970: 25200)
        )
        // 8:00
        XCTAssertEqual(
            SwiftToTen.live(time: "8 o'clock", calendar: .test),
            Date(timeIntervalSince1970: 28800)
        )
        // 14:00
        XCTAssertEqual(
            SwiftToTen.live(time: "2 o'clock in the afternoon", calendar: .test),
            Date(timeIntervalSince1970: 50400)
        )
    }

    func testMidnight() {
        // 00:00
        XCTAssertEqual(
            SwiftToTen.live(time: "midnight", calendar: .test),
            Date(timeIntervalSince1970: 0)
        )

        // 00:00
        XCTAssertEqual(
            SwiftToTen.live(time: "Midnight", calendar: .test),
            Date(timeIntervalSince1970: 0)
        )
    }

    func testToMidnight() {
        // 23:50
        XCTAssertEqual(
            SwiftToTen.live(time: "10 to midnight", calendar: .test),
            Date(timeIntervalSince1970: 85800)
        )
    }

    func testPastMidnight() {
        // 00:20
        XCTAssertEqual(
            SwiftToTen.live(time: "20 past midnight", calendar: .test),
            Date(timeIntervalSince1970: 1200)
        )
    }

    func testQuarterToMidnight() {
        // 23:45
        XCTAssertEqual(
            SwiftToTen.live(time: "quarter to midnight", calendar: .test),
            Date(timeIntervalSince1970: 85500)
        )
    }

    func testQuarterPastMidnight() {
        // 00:15
        XCTAssertEqual(
            SwiftToTen.live(time: "quarter past midnight", calendar: .test),
            Date(timeIntervalSince1970: 900)
        )
    }

    func testHalfToMidnight() {
        // 23:30
        XCTAssertEqual(
            SwiftToTen.live(time: "half to midnight", calendar: .test),
            Date(timeIntervalSince1970: 84600)
        )
    }

    func testHalfPastMidnight() {
        // 00:30
        XCTAssertEqual(
            SwiftToTen.live(time: "half past midnight", calendar: .test),
            Date(timeIntervalSince1970: 1800)
        )
    }

    static var allTests = [
        ("testSomeHours", testSomeHours),
        ("testPostMeridiem", testPostMeridiem),
        ("testOClock", testOClock),
        ("testMidnight", testMidnight),
        ("testToMidnight", testToMidnight),
        ("testPastMidnight", testPastMidnight),
        ("testQuarterToMidnight", testQuarterToMidnight),
        ("testQuarterPastMidnight", testQuarterPastMidnight),
        ("testHalfToMidnight", testHalfToMidnight),
        ("testHalfPastMidnight", testHalfPastMidnight),
    ]
}

extension Calendar {
    static var test: Self {
        var calendar = Self(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0) ?? calendar.timeZone
        return calendar
    }
}
