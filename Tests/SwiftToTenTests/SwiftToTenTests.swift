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

    static var allTests = [
        ("testSomeHours", testSomeHours),
        ("testPostMeridiem", testPostMeridiem),
    ]
}

extension Calendar {
    static var test: Self {
        var calendar = Self(identifier: .gregorian)
        calendar.timeZone = TimeZone(secondsFromGMT: 0) ?? calendar.timeZone
        return calendar
    }
}
