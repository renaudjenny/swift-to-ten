import Dependencies
import Foundation
@_exported import SwiftToTen
import XCTestDynamicOverlay

extension SwiftToTen {
    static let test = Self(recognizeTime: unimplemented("SwiftToTen.recognizeTime"))
    static let preview = SwiftToTen.live
}

private enum SwiftToTenDependencyKey: DependencyKey {
    static let liveValue = SwiftToTen.live
    static let testValue = SwiftToTen.test
    static let previewValue = SwiftToTen.preview
}

public extension DependencyValues {
    var recognizeTime: SwiftToTen {
        get { self[SwiftToTenDependencyKey.self] }
        set { self[SwiftToTenDependencyKey.self] = newValue }
    }
}
