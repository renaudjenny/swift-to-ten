import Foundation
import SwiftRegex

public enum SwiftToTen {
    public static func recognizeTime(in time: String, calendar: Calendar) -> Date? {
        guard let (hourString, minuteString): (String, String) = time.firstMatch(of: "(\\d{1,2}):(\\d{2})"),
              let hour = Int(hourString),
              let minute = Int(minuteString)
        else { return nil }

        let epoch = Date(timeIntervalSince1970: 0)

        // Find potential pm in the string
        if time.containsMatch(of: "\\d{1,2}:\\d{2} (pm)") {
            // It's in the afternoon, so we just add 12 hours to the hour found
            return calendar.date(bySettingHour: hour + 12, minute: minute, second: 0, of: epoch)
        }

        return calendar.date(bySettingHour: hour, minute: minute, second: 0, of: epoch)
    }
}
