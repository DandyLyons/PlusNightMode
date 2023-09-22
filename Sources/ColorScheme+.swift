//
//  File.swift
//  
//
//  Created by Daniel Lyons on 9/22/23.
//

import SwiftUI

extension ColorScheme: CustomDebugStringConvertible {
  public var debugDescription: String {
    switch self {
      case .light:
        ".light"
      case .dark:
        ".dark"
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
  @ViewBuilder
  /// A convenience `View` that will adapt to the provided `ColorScheme`
  /// - Parameters:
  ///   - colorScheme: The SwiftUI `ColorScheme`
  ///   - light: The View to display when `colorScheme` is `.light`
  ///   - dark: The View to display when `colorScheme` is `.dark`
  /// - Returns: The Light and Dark View
  func view<L: View, D: View>(for colorScheme: ColorScheme, light: () -> L, dark: () -> D) -> some View {
    switch colorScheme {
      case .light: light()
      case .dark: dark()
      @unknown default: dark()
    }
  }
}
