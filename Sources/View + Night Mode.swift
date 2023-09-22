//
//  File.swift
//  
//
//  Created by Daniel Lyons on 9/20/23.
//

import SwiftUI

extension View {
  
  
  @ViewBuilder
  public func observingNightMode(_ bool: Bool = true) -> some View {
    nightModed(if: bool)
  }
  
  @ViewBuilder
  public func observingNightMode(_ colorSchemeMode: Binding<ColorSchemeMode>) -> some View {
    let bool = colorSchemeMode.wrappedValue == .night
    @Environment(\.colorScheme) var colorScheme
    
    nightModed(if: bool)
      .environment(\.colorSchemeMode, colorSchemeMode)
      .colorScheme(colorSchemeMode.wrappedValue.value.resolvedColorScheme ?? colorScheme)
  }
  
  public func nightModed(if bool: Bool) -> some View {
    monochromed(if: bool, color: .red, colorScheme: .dark)
  }
}
