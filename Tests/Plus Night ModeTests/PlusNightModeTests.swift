import XCTest
@testable import PlusNightMode
import SnapshotTesting
import SwiftUI

@available(macOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
final class PlusNightModeTests: XCTestCase {
  @MainActor
  func testSnapshot() {
    isRecording = true
    var view = ExampleNightModeView.light
    var hostingController = UIHostingController(rootView: view)
    
    let screenBounds = UIScreen.main.bounds

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
