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
      self
        .monochromed(color: .red, colorScheme: .dark)
        .environment(\.colorSchemeMode, .constant(.night))
    } else {
      self
    }
  }
  
  @ViewBuilder
  public func observingNightMode(_ colorSchemeMode: ColorSchemeMode) -> some View {
    if colorSchemeMode == .night {
      self
        .monochromed(color: .red, colorScheme: .dark)
        .environment(\.colorSchemeMode, .constant(.night))
//        .id(1)
    } else {
      self
        .environment(\.colorSchemeMode, .constant(colorSchemeMode))
//        .id(1)
    }
  }
}