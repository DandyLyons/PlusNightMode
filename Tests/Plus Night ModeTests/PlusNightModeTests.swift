import XCTest
@testable import PlusNightMode
import SnapshotTesting

import SwiftUI

@available(macOS, unavailable)
@available(watchOS, unavailable)
@available(tvOS, unavailable)
final class PlusNightModeTests: XCTestCase {
  @MainActor
  func testSnapshot_iOS() {
    withSnapshotTesting(record: .never, diffTool: .default) {
      let view = ExampleNightModeView.auto
      var hostingController = UIHostingController(rootView: view)
      let screenBounds = UIScreen.main.bounds
      hostingController.view.frame = screenBounds
      
      hostingController.rootView = ExampleNightModeView.night
      assertSnapshot(
        of: hostingController,
        as: .recursiveDescription,
        named: "Night Mode"
      )
      
      hostingController.rootView = ExampleNightModeView.light
      assertSnapshot(
        of: hostingController,
        as: .recursiveDescription,
        named: "Light Mode"
      )

      hostingController.rootView = ExampleNightModeView.dark
      assertSnapshot(
        of: hostingController,
        as: .recursiveDescription,
        named: "Dark Mode"
      )

      hostingController.rootView = ExampleNightModeView.auto
      assertSnapshot(
        of: hostingController,
        as: .recursiveDescription,
        named: "Auto Mode"
      )
    }
    
  }
}
