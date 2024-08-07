//
//  NightModeView.swift
//
//  Created by Daniel Lyons on 9/12/23.
//

import SwiftUI
import Foundation


/// An example `View` to demonstrate how ``colorSchemeMode(_:)`` affects appearance.
///
/// Also used in tests.
@available(iOS 16.0, macOS 13.0, *)
public struct ExampleNightModeView: View {
  public init(colorSchemeMode: ColorSchemeMode = .night) {
    self._colorSchemeMode = State(initialValue: colorSchemeMode)
  }
  
  @State public var colorSchemeMode: ColorSchemeMode
  @Environment(\.colorScheme) var colorScheme
//  @Environment(\.shouldDifferentiateWithoutColor) var shouldDifferentiateWithoutColor
  
  public var body: some View {
    NavigationStack {
      List {
//        Image("blindingWhite", bundle: .main)
        Image(ImageResource(name: "blindingWhite", bundle: .module))
          .resizable()
          .frame(maxWidth: .infinity)
          .aspectRatio(1.0, contentMode: .fill)
        Text("This is a text view")
        Text("Blue").foregroundStyle(.blue)
        Text("Green").foregroundStyle(.green)
        Text("Yellow").foregroundStyle(.yellow)
        NavigationLink("Go to Settings", value: "Settings")
        
        Section {
          Picker("ColorSchemeMode", selection: $colorSchemeMode) {
            Text("Night").tag(ColorSchemeMode.night)
            Text("Dark").tag(ColorSchemeMode.dark)
            Text("Light").tag(ColorSchemeMode.light)
            Text("Auto").tag(ColorSchemeMode.auto)
          }
          .pickerStyle(.menu)
          
          Text("ColorScheme: \(colorScheme.debugDescription)")
          Text("ColorSchemeMode: \(colorSchemeMode.debugDescription)")
        }
        
        
      }
      .navigationTitle("Hello World!")
      .navigationDestination(for: String.self) { string in
        ExampleSettingsView()
      }
    }
    .colorSchemeMode($colorSchemeMode)
  }
}

/// An example Settings screen `View` to demonstrate how ``colorSchemeMode(_:)`` affects appearance.
///
/// Also used in tests.
@MainActor // This shouldn't be necessary post Xcode 16 since `View` will be `@MainActor` isolated
extension ExampleNightModeView {
  static let night = Self(colorSchemeMode: .night)
  static let light = Self(colorSchemeMode: .light)
  static let auto = Self(colorSchemeMode: .auto)
  static let dark = Self(colorSchemeMode: .dark)
}


public struct ExampleSettingsView: View {
  @Environment(\.colorSchemeMode) private var colorSchemeMode
  
  @Environment(\.colorScheme) private var colorScheme
  @State private var preferredColorScheme: ColorScheme = .light
  
  public var body: some View {
    Form {
      Picker("ColorScheme", selection: $preferredColorScheme) {
        Text("Dark").tag(ColorScheme.dark)
        Text("Light").tag(ColorScheme.light)
      }
      .pickerStyle(.menu)

      Picker("ColorSchemeMode", selection: colorSchemeMode) {
        Text("Night").tag(ColorSchemeMode.night)
        Text("Dark").tag(ColorSchemeMode.dark)
        Text("Light").tag(ColorSchemeMode.light)
        Text("Auto").tag(ColorSchemeMode.auto)
      }
      .pickerStyle(.menu)
      
      
      Section {
        Text("ColorScheme: \(colorScheme.debugDescription)")      }
    }
    .navigationTitle("Settings")
  }
}

#Preview("Night") {
  ExampleNightModeView.night
}

#Preview("Light") {
  ExampleNightModeView.light
}
#Preview("Dark") {
  ExampleNightModeView.dark
}
#Preview("Auto") {
  ExampleNightModeView.auto
}

