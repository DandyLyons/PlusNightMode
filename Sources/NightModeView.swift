//
//  NightModeView.swift
//
//  Created by Daniel Lyons on 9/12/23.
//

import SwiftUI

@available(iOS 16.0, *)
struct NightModeView: View {
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

extension View {
  @ViewBuilder
  public func observingNightMode(_ bool: Bool) -> some View {
    if bool {
      self.monochromed(color: .red, colorScheme: .dark)
    } else {
      self
    }
  }
  
  public func monochromed(color: Color, colorScheme: ColorScheme = .dark) -> some View {
    let filter: some View = color
      .blendMode(.color)
      .opacity(0.5)
      .allowsHitTesting(false)
    
    return self
      .preferredColorScheme(colorScheme)
      .tint(color)
      .overlay {
        filter
          .ignoresSafeArea()
      }
      .colorMultiply(color)
  }
}


