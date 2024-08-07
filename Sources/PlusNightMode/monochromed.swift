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
  public func monochromed(if bool: Bool, color: Color, colorScheme: ColorScheme) -> some View {
    let filter: some View = color
      .blendMode(bool ? .color : .normal)
      .opacity(bool ? 0.5 : 0.0)
      .allowsHitTesting(false)
      .ignoresSafeArea()
    
    return self
      .preferredColorScheme(bool ? colorScheme : nil)
      .tint(bool ? color : nil)
      .overlay {
        filter
      }
      .colorMultiply(bool ? color : .white)
  }
}
