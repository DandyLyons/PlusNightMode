//
//  NightModeView.swift
//
//  Created by Daniel Lyons on 9/12/23.
//

import SwiftUI

@available(iOS 16.0, macOS 14.0, *)
struct ExampleNightModeView: View {
    var body: some View {
      NavigationStack {
        List {
          Image("blindingWhite")
            .resizable()
            .frame(maxWidth: .infinity)
            .aspectRatio(1.0, contentMode: .fill)
          Text("This is a text view")
          Text("Blue").foregroundStyle(.blue)
          Text("Green").foregroundStyle(.green)
          Text("Yellow").foregroundStyle(.yellow)
          NavigationLink("Go to Settings", value: "Settings")
        }
        .navigationTitle("Hello World!")
        .navigationDestination(for: String.self) { string in
          SettingsPage()
        }
      }
      .observingNightMode(true)
    }
}

struct SettingsPage: View {
  @Environment(\.colorSchemeMode) var colorSchemeMode
  
  var body: some View {
    Form {
      Picker("Appearance", selection: colorSchemeMode) {
        Text("Night").tag(ColorSchemeMode.night)
        Text("Dark").tag(ColorSchemeMode.night)
        Text("Light").tag(ColorSchemeMode.night)
        Text("Auto").tag(ColorSchemeMode.night)
      }
      .pickerStyle(.segmented)
    }
    .navigationTitle("Settings")
  }
}

//#Preview {
//  if #available(iOS 16.0, macOS 14.0, *) {
//    ExampleNightModeView()
//  } else if #available(iOS 13.0, macOS 10.15, *) {
//    Text("Requires 16.0 or higher")
//  }
//}


