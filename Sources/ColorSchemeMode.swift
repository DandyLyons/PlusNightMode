//
//  ColorSchemeMode.swift
//  GarageBuddy
//
//  Created by Daniel Lyons on 6/1/23.
//

import Foundation
import SwiftUI

// Conform to EnvironmentKey
public struct ColorSchemeModeBindingKey: EnvironmentKey {
  public static var defaultValue: Binding<ColorSchemeMode> {
    .constant(.auto)
  }
}



// Conform to DynamicProperty to create a projected value
extension EnvironmentValues {
  var colorSchemeMode: Binding<ColorSchemeMode> {
    get { self[ColorSchemeModeBindingKey.self] }
    set { self[ColorSchemeModeBindingKey.self] = newValue }
  }
}

public struct ColorSchemeMode: Identifiable, Hashable {
  public static func == (lhs: ColorSchemeMode, rhs: ColorSchemeMode) -> Bool {
    lhs.value == rhs.value
  }
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(value)
  }
  
  @Binding var value: Value
  
  public var id: String { self.value.rawValue }
  
  static let auto: Self = .init(value: .constant(.auto))
  static let light: Self = .init(value: .constant(.light))
  static let dark: Self = .init(value: .constant(.dark))
  static let night: Self = .init(value: .constant(.night))
  
  /// A wrapper enum that provides extra functionality to SwiftUI's `ColorScheme`
  ///
  /// To get the underlying `ColorScheme` value, use `resolvedColorScheme`
  public enum Value: String, CaseIterable, Hashable, Codable, Identifiable {
    /// Light Mode
    case light = "Light"
    /// Dark Mode
    case dark = "Dark"
    /// A View presentation designed to minimize negative impact to sleep where every
    /// pixel is either pitch black or a shade of red.
    /// Note: Night Mode is not built into the system. Instead, you can observe the `\.colorSchemeMode`
    /// EnvironmentKey and respond to it using `observingNightMode()`
    case night = "Night"
    /// In this mode, the App will simply observe the Dark/Light mode setting of the device.
    case auto = "Automatic"
    
    public var id: String { self.rawValue }
    
    public init(rawValue: String) {
      switch rawValue {
        case Self.light.rawValue: self = .light
        case Self.dark.rawValue: self = .dark
        case Self.night.rawValue: self = .night
        case Self.auto.rawValue: self = .auto
        default: self = .auto
      }
    }
    
    public var localizedString: LocalizedStringKey {
      return LocalizedStringKey(self.rawValue)
    }
    
    /// for use in `View.preferredColorScheme`
    public var resolvedColorScheme: SwiftUI.ColorScheme? {
      switch self {
        case .light: return .light
        case .dark: return .dark
        case .night: return .dark
        case .auto: return nil
      }
    }
  }
}
//
//
//public struct ColorSchemeModeKey: EnvironmentKey {
//  public static var defaultValue: ColorSchemeMode = .auto
//}
//
//public extension ColorScheme {
//  var opposite: Self {
//    switch self {
//      case .light: .dark
//      case .dark: .light
//      @unknown default: .dark
//    }
//  }
//}
//
//// MARK: EnvironmentValues
//extension EnvironmentValues {
//  public var colorSchemeMode: ColorSchemeMode {
//    get { self[ColorSchemeModeKey.self] }
//    set { self[ColorSchemeModeKey.self] = newValue }
//  }
//}
//
// MARK: CustomDebugStringConvertible
extension ColorSchemeMode: CustomDebugStringConvertible {
  public var debugDescription: String {
    return self.value.rawValue
  }
}
//
//
//
//public extension View {
//  
//  @ViewBuilder
//  /// A convenience `View` that will adapt to the provided `ColorScheme`
//  /// - Parameters:
//  ///   - colorScheme: The SwiftUI `ColorScheme`
//  ///   - light: The View to display when `colorScheme` is `.light`
//  ///   - dark: The View to display when `colorScheme` is `.dark`
//  /// - Returns: The Light and Dark View
//  func view<L: View, D: View>(for colorScheme: ColorScheme, light: () -> L, dark: () -> D) -> some View {
//    switch colorScheme {
//      case .light: light()
//      case .dark: dark()
//      @unknown default: dark()
//    }
//  }
//}


