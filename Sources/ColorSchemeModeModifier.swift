//
//  File.swift
//  
//
//  Created by Daniel Lyons on 9/22/23.
//

import SwiftUI

// Conform to ViewModifier to set the environment value
public struct ColorSchemeModeEnvironmentKeyModifier: ViewModifier {
  @Binding var mode: ColorSchemeMode
  
  public func body(content: Content) -> some View {
    content
      .preferredColorScheme(mode.value.resolvedColorScheme)
      .observingNightMode($mode)
  }
}

// Extend View to provide a modifier for setting the environment value
extension View {
  public func colorSchemeMode(_ mode: Binding<ColorSchemeMode>) -> some View {
    self.modifier(ColorSchemeModeEnvironmentKeyModifier(mode: mode))
  }
}
