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
  public func monochromed(if bool: Bool, color: Color, colorScheme: ColorScheme = .dark) -> some View {
//    let filter: some View = color
//      .blendMode(.color)
//      .opacity(0.5)
//      .allowsHitTesting(false)
//    
//    return self
//      .preferredColorScheme(colorScheme)
//      .tint(color)
//      .overlay {
//        if bool {
//          filter
//            .ignoresSafeArea()
//        } else {
//          EmptyView()
//        }
//      }
//      .colorMultiply(color)
    self.modifier(Monochromed(bool: bool, color: color, colorScheme: colorScheme))
  }
}

struct Monochromed: ViewModifier {
  @Environment(\.colorSchemeMode) private var colorSchemeMode
  
  
  var bool: Bool
  var color: Color
  var colorScheme: ColorScheme
  
  init(bool: Bool, color: Color = .red, colorScheme: ColorScheme) {
    self.bool = bool
    self.color = color
    self.colorScheme = colorScheme
  }
  
  func body(content: Content) -> some View {
    let _ = print("in Monochromed: @Environment(\\.colorSchemeMode) = \(colorSchemeMode.wrappedValue)")
    
    let filter: some View = color
      .blendMode(.color)
      .opacity(0.5)
      .allowsHitTesting(false)
      .ignoresSafeArea()
    
    if colorSchemeMode.wrappedValue == .night {
      content
        .colorScheme(.dark)
//        .preferredColorScheme(colorSchemeMode.wrappedValue.value.resolvedColorScheme)
      //      .preferredColorScheme(.dark)
        .tint(color)
        .overlay {
            filter
              .ignoresSafeArea()
          }
        .colorMultiply(color)
        .id(1)
    } else {
      content
        .id(1)
    }
  }
}
