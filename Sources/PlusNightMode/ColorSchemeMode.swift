//
//  File.swift
//  
//
//  Created by Daniel Lyons on 9/22/23.
//

import Foundation
import SwiftUI

/// A wrapper type that provides extra functionality to SwiftUI's `ColorScheme`
///
/// To get the underlying `ColorScheme` value, use `resolvedColorScheme`
public struct ColorSchemeMode: Sendable {
  public var value: Value
  
  
  public var resolvedColorScheme: ColorScheme? {
    return value.resolvedColorScheme
  }
  
  public init(value: Value) {
    self.value = value
  }

  /// The underlying value of the ``ColorSchemeMode``.
  public enum Value: String, CaseIterable, Hashable, Codable, Identifiable, Sendable {
    /// Light Mode
    case light = "Light"
    /// Dark Mode
    case dark = "Dark"
    /// A View presentation designed to minimize the negative impact of harmful sleep-depriving blue light.
    /// This appearance effectively makes it so that every pixel is either pitch black or a shade of red.
    /// Note: Night Mode is not built into the system. Instead, you can observe the `\.colorSchemeMode`
    /// EnvironmentKey and respond to it using `observingNightMode()` or `colorSchemeMode(_:)`
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
