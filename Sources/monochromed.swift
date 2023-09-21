//
//  File.swift
//  
//
//  Created by Daniel Lyons on 9/20/23.
//

import SwiftUI

extension View {
  /// The actual function that makes Night Mode possible.
  /// If you would like to use Night Mode, then call `observingNightMode` instead.
  /// This function is available if you would like to use other Colors.
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
