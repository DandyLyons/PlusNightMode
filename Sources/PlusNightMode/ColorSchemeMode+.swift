import Foundation
import SwiftUI

// MARK: EnvironmenValues
extension EnvironmentValues {
  public var colorSchemeMode: Binding<ColorSchemeMode> {
    get { self[ColorSchemeModeBindingKey.self] }
    set { self[ColorSchemeModeBindingKey.self] = newValue }
  }
}

public struct ColorSchemeModeBindingKey: EnvironmentKey {
  public static var defaultValue: Binding<ColorSchemeMode> {
    .constant(.auto)
  }
}

extension ColorSchemeMode {
  public var stringDescription: String {
    return self.value.rawValue
  }
}

// MARK: CaseIterable
extension ColorSchemeMode: CaseIterable {
  public static var allCases: [ColorSchemeMode] {
    [.auto, .dark, .light, .night]
  }
  
  public static let auto: Self = .init(value: .auto)
  public static let light: Self = .init(value: .light)
  public static let dark: Self = .init(value: .dark)
  public static let night: Self = .init(value: .night)
}

// MARK: Codable
extension ColorSchemeMode: Codable {
  public enum CodingKeys: CodingKey { case value }
  
  public init(from decoder: Decoder) throws {
    
    let container = try decoder.container(keyedBy: CodingKeys.self)
    
    let decodedValue = try container.decode(Value.self, forKey: .value)
    
    self.init(value: decodedValue)
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


// MARK: LocalizedStringKey
extension ColorSchemeMode {
  public var localizedString: LocalizedStringKey {
    return LocalizedStringKey(self.value.rawValue)
  }
}
