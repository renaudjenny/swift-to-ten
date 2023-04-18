import Foundation
import SwiftRegex

public struct SwiftToTen {
    public var recognizeTime: (String, Calendar) -> Date?

    public init(recognizeTime: @escaping (String, Calendar) -> Date?) {
        self.recognizeTime = recognizeTime
    }

    public func callAsFunction(time: String, calendar: Calendar) -> Date? {
        recognizeTime(time, calendar)
    }
}

extension SwiftToTen {
    public static let live = Self(recognizeTime: { RecognizeTime(calendar: $1).recognizeTime(in: $0) })
}

struct RecognizeTime {
    let epoch = Date(timeIntervalSince1970: 0)

    var calendar: Calendar

    func recognizeTime(in time: String) -> Date? {
        if let oClockDate = oClockDate(time: time) {
            return oClockDate
        } else if let toMidnightDate = toMidnightDate(time: time) {
            return toMidnightDate
        } else if let pastMidnightDate = pastMidnightDate(time: time) {
            return pastMidnightDate
        } else if let midnightDate = midnightDate(time: time) {
            return midnightDate
        }

        guard let (hourString, minuteString): (String, String) = time.firstMatch(of: "(\\d{1,2}):(\\d{2})"),
              let hour = Int(hourString),
              let minute = Int(minuteString)
        else { return nil }

        // Find potential pm in the string
        if time.containsMatch(of: "\\d{1,2}:\\d{2} (pm)") {
            // It's in the afternoon, so we just add 12 hours to the hour found
            return calendar.date(bySettingHour: hour + 12, minute: minute, second: 0, of: epoch)
        }

        return calendar.date(bySettingHour: hour, minute: minute, second: 0, of: epoch)
    }

    private func oClockDate(time: String) -> Date? {
        guard let hourString: String = time.firstMatch(of: "(\\d{1,2}) o'clock"),
              let hour = Int(hourString)
        else { return nil }

        // Find potential "in the afternoon" in the string
        if time.containsMatch(of: "\\d{1,2} o'clock in the afternoon") {
            // It's in the afternoon, so we just add 12 hours to the hour found
            return calendar.date(bySettingHour: hour + 12, minute: 0, second: 0, of: epoch)
        }

        return calendar.date(bySettingHour: hour, minute: 0, second: 0, of: epoch)
    }

    private func toMidnightDate(time: String) -> Date? {
        if time.containsMatch(of: "[q|Q]uarter to [m|M]idnight") {
            return calendar.date(bySettingHour: 23, minute: 45, second: 0, of: epoch)
        }
        if time.containsMatch(of: "[h|H]alf to [m|M]idnight") {
            return calendar.date(bySettingHour: 23, minute: 30, second: 0, of: epoch)
        }

        guard let minuteString: String = time.firstMatch(of: "(\\d{1,2}) to [m|M]idnight"),
              let minute = Int(minuteString)
        else { return nil }

        return calendar.date(bySettingHour: 23, minute: 60 - minute, second: 0, of: epoch)
    }

    private func pastMidnightDate(time: String) -> Date? {
        if time.containsMatch(of: "[q|Q]uarter past [m|M]idnight") {
            return calendar.date(bySettingHour: 00, minute: 15, second: 0, of: epoch)
        }
        if time.containsMatch(of: "[h|H]alf past [m|M]idnight") {
            return calendar.date(bySettingHour: 00, minute: 30, second: 0, of: epoch)
        }

        guard let minuteString: String = time.firstMatch(of: "(\\d{1,2}) past [m|M]idnight"),
              let minute = Int(minuteString)
        else { return nil }

        return calendar.date(bySettingHour: 0, minute: minute, second: 0, of: epoch)
    }

    private func midnightDate(time: String) -> Date? {
        if time.containsMatch(of: "[m|M]idnight") {
            return calendar.date(bySettingHour: 0, minute: 0, second: 0, of: epoch)
        }
        return nil
    }
}
