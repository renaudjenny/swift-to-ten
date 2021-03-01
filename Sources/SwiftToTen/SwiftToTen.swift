import Foundation
import SwiftRegex

public enum SwiftToTen {
    public static func recognizeTime(in time: String, calendar: Calendar) -> Date? {
        guard let (hourString, minuteString): (String, String) = time.firstMatch(of: "(\\d{1,2}):(\\d{2})"),
              let hour = Int(hourString),
              let minute = Int(minuteString)
        else { return nil }

        let epoch = Date(timeIntervalSince1970: 0)
        return calendar.date(bySettingHour: hour, minute: minute, second: 0, of: epoch)
    }
}
