import SwiftUI

extension ColorScheme {
  /// Like a "debugDescription" from `CustomDebugStringConvertible` but without the `@retroactive` protocol conformance.
  public var stringDescription: String {
    switch self {
      case .light: ".light"
      case .dark: ".dark"
      @unknown default: "@unknown default"
    }
  }
}

public extension ColorScheme {
  var opposite: Self {
    switch self {
      case .light: .dark
      case .dark: .light
      @unknown default: .dark
    }
  }
}

public extension View {
  /// A convenience `View` that will override the light and dark appearance according to the provided `ColorScheme`
  /// - Parameters:
  ///   - colorScheme: The SwiftUI `ColorScheme`
  ///   - light: The View to display when `colorScheme` is `.light`
  ///   - dark: The View to display when `colorScheme` is `.dark`
  /// - Returns: The Light and Dark View
  @ViewBuilder
  func view<L: View, D: View>(for colorScheme: ColorScheme, light: () -> L, dark: () -> D) -> some View {
    switch colorScheme {
      case .light: light()
      case .dark: dark()
      @unknown default: dark()
    }
  }
  
  /// A convenience `View` that will override the light and dark appearance.
  /// - Parameters:
  ///   - colorScheme: The SwiftUI `ColorScheme`
  ///   - light: The View to display when `colorScheme` is `.light`
  ///   - dark: The View to display when `colorScheme` is `.dark`
  /// - Returns: The Light and Dark View
  @ViewBuilder
  func view<L: View, D: View>(@ViewBuilder light: () -> L, @ViewBuilder dark: () -> D) -> some View {
    @Environment(\.colorScheme) var colorScheme
    switch colorScheme {
      case .light: light()
      case .dark: dark()
      @unknown default: dark()
    }
  }
}
