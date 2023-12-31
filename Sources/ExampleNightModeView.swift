//
//  NightModeView.swift
//
//  Created by Daniel Lyons on 9/12/23.
//

import SwiftUI
import Foundation



@available(iOS 16.0, macOS 13.0, *)
public struct ExampleNightModeView: View {
  static let night = Self(colorSchemeMode: .night)
  static let light = Self(colorSchemeMode: .light)
  static let auto = Self(colorSchemeMode: .auto)
  static let dark = Self(colorSchemeMode: .dark)
  
  public init(colorSchemeMode: ColorSchemeMode = .night) {
    self._colorSchemeMode = State(initialValue: colorSchemeMode)
  }
  
  @State public var colorSchemeMode: ColorSchemeMode
  @Environment(\.colorScheme) var colorScheme
  
  public var body: some View {
    NavigationStack {
      List {
        Image("blindingWhite", bundle: .module)
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
        SettingsPage()
      }
    }
    .colorSchemeMode($colorSchemeMode)
  }
}

public struct SettingsPage: View {
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

