//
//  ColorSchemeMode.swift
//  GarageBuddy
//
//  Created by Daniel Lyons on 6/1/23.
//

import Foundation
import SwiftUI
import Dependencies
import DependenciesAdditions

public enum ColorSchemeMode: String, CaseIterable, Hashable, Codable, Identifiable {
  case light = "Light"
  case dark = "Dark"
  case night = "Night"
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

extension ColorSchemeMode: CustomDebugStringConvertible {
  public var debugDescription: String {
    return self.rawValue
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
  func view<L: View, D: View>(for colorScheme: ColorScheme, light: () -> L, dark: () -> D) -> some View {
    switch colorScheme {
      case .light: light()
      case .dark: dark()
      @unknown default: dark()
    }
  }
}

// MARK: UserDefaults
public extension UserDefaults {
  static let key_colorSchemeMode = "COLOR_SCHEME_MODE"
}

extension ColorSchemeMode {
  /// retrieves the ColorSchemeMode from UserDefaults
  /// If there is no ColorSchemeMode value, then sets it to `.auto`, saves it to
  /// UserDefaults and then returns that value
  /// - Returns: The UserDefaults value of ColorSchemeMode, (`.auto` if there is none).
  public static func getFromUserDefaults() -> Self {
    @Dependency(\.userDefaults) var userDefaults
    @Dependency(\.decode) var decode
    if let data = userDefaults.data(forKey: UserDefaults.key_colorSchemeMode),
       let ud_colorSchemeMode = try? decode(ColorSchemeMode.self, from: data) {
      return ud_colorSchemeMode
    } else {
      @Dependency(\.encode) var encode
      let colorSchemeMode: ColorSchemeMode = .auto
      let data: Data? = try? encode(colorSchemeMode)
      userDefaults.set(data, forKey: UserDefaults.key_colorSchemeMode)
      return colorSchemeMode
    }
  }
}
