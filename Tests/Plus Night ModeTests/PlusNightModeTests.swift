import XCTest
@testable import PlusNightMode
import SnapshotTesting
import SwiftUI

#if canImport(UIKit)
import UIKit
#elseif canImport(AppKit)
import AppKit
#endif

final class PlusNightModeTests: XCTestCase {
  @MainActor
  func testSnapshot() {
    isRecording = true
    var view = ExampleNightModeView.light
    var hostingController = CrossPlatformHostingController(rootView: view)
    
#if os(iOS)
    let screenBounds = UIScreen.main.bounds
#elseif os(macOS)
    let screenBounds = NSScreen.main?.visibleFrame ?? NSRect(x: 0, y: 0, width: 1024, height: 768)
#endif
    
    hostingController.view.frame = screenBounds
    
    hostingController.rootView = ExampleNightModeView.night
    assertSnapshot(of: hostingController, as: .image, timeout: 0.5)
    XCTFail("This snapshot does not look correct")
    
    hostingController.rootView = ExampleNightModeView.light
    assertSnapshot(of: hostingController, as: .image, timeout: 0.5)
    XCTFail("This snapshot does not look correct")
    
    hostingController.rootView = ExampleNightModeView.dark
    assertSnapshot(of: hostingController, as: .image, timeout: 0.5)
    XCTFail("This snapshot does not look correct")
    
    hostingController.rootView = ExampleNightModeView.auto
    assertSnapshot(of: hostingController, as: .image, timeout: 0.5)
    XCTFail("This snapshot does not look correct")
  }
}

#if os(iOS)
typealias CrossPlatformHostingController = UIHostingController
#elseif os(macOS)
class CrossPlatformHostingController<Content: View>: NSHostingController<Content> {
}
#endif
