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
          NavigationLink("Go to second page", value: "second page")
        }
        .navigationTitle("Hello World!")
        .navigationDestination(for: String.self) { string in
          Text(string)
        }
      }
      .observingNightMode(true)
    }
}

//#Preview {
//  if #available(iOS 16.0, macOS 14.0, *) {
//    ExampleNightModeView()
//  } else if #available(iOS 13.0, macOS 10.15, *) {
//    Text("Requires 16.0 or higher")
//  }
//}


