import XCTest
@testable import PlusNightMode
import SnapshotTesting
import SwiftUI

final class PlusNightModeTests: XCTestCase {
  func testSnapshot() {
//    isRecording = true
    var view = ExampleNightModeView.light
    var vc = UIHostingController(rootView: view)
    vc.view.frame = UIScreen.main.bounds
    vc.rootView = ExampleNightModeView.night
    assertSnapshot(of: vc, as: .image(on: .iPhone13Pro), timeout: 0.5)
    
    vc.rootView = ExampleNightModeView.light
    assertSnapshot(of: vc, as: .image(on: .iPhone13Pro), timeout: 0.5)
    
    vc.rootView = ExampleNightModeView.dark
    assertSnapshot(of: vc, as: .image(on: .iPhone13Pro), timeout: 0.5)
    
    vc.rootView = ExampleNightModeView.auto
    assertSnapshot(of: vc, as: .image(on: .iPhone13Pro), timeout: 0.5)
    
  }
}
