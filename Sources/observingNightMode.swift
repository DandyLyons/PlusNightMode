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
    if bool {
      monochromed(if: bool, color: .red, colorScheme: .dark)
        .environment(\.colorSchemeMode, .constant(.dark))
    } else {
      self
    }
  }
  
  @ViewBuilder
  public func observingNightMode(_ colorSchemeMode: Binding<ColorSchemeMode>) -> some View {
    let bool = colorSchemeMode.wrappedValue == .night
    @Environment(\.colorScheme) var colorScheme
    
    monochromed(if: bool, color: .red)
      .environment(\.colorSchemeMode, colorSchemeMode)
      .colorScheme(colorSchemeMode.wrappedValue.value.resolvedColorScheme ?? colorScheme)
    
//    if bool {
//      let _ = print("observingNightMode: night case")
//      
//      environment(\.colorSchemeMode, colorSchemeMode)
//        .monochromed(if: bool, color: .red, colorScheme: .dark)
//        .id(1)
//    } else {
//      let _ = print("observingNightMode: NON night case")
//      environment(\.colorSchemeMode, colorSchemeMode)
//        .id(1)
//    }
  }
}
