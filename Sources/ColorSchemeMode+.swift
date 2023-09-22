//
//  File.swift
//  
//
//  Created by Daniel Lyons on 9/22/23.
//

import Foundation
import SwiftUI

// MARK: EnvironmenValues
extension EnvironmentValues {
  var colorSchemeMode: Binding<ColorSchemeMode> {
    get { self[ColorSchemeModeBindingKey.self] }
    set { self[ColorSchemeModeBindingKey.self] = newValue }
  }
}

public struct ColorSchemeModeBindingKey: EnvironmentKey {
  public static var defaultValue: Binding<ColorSchemeMode> {
    .constant(.auto)
  }
}

// MARK: CustomDebugStringConvertible
extension ColorSchemeMode: CustomDebugStringConvertible {
  public var debugDescription: String {
    return self.value.rawValue
  }
}

// MARK: CaseIterable
extension ColorSchemeMode: CaseIterable {
  public static var allCases: [ColorSchemeMode] {
    [.auto, .dark, .light, .night]
  }
}

// MARK: Codable
extension ColorSchemeMode: Codable {
  public enum CodingKeys: CodingKey { case value }
  
  public init(from decoder: Decoder) throws {
    self.init(value: .constant(.auto))
    
    let container = try decoder.container(keyedBy: CodingKeys.self)
    self.value = try container.decode(Value.self, forKey: .value)
  }
  
  public func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(value, forKey: .value)
  }
}

// MARK: Equatable, Hashable
extension ColorSchemeMode: Equatable, Hashable {
  public static func == (lhs: ColorSchemeMode, rhs: ColorSchemeMode) -> Bool {
    lhs.value == rhs.value
  }
  
  public func hash(into hasher: inout Hasher) {
    hasher.combine(value)
  }
}

// MARK: Identifiable
extension ColorSchemeMode: Identifiable {
  public var id: String { self.value.rawValue }
}


