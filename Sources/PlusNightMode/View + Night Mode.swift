import SwiftUI

extension View {
  
  
  @ViewBuilder
  public func observingNightMode(_ bool: Bool = true) -> some View {
    nightModed(if: bool)
  }
  
  @ViewBuilder
  func observingNightMode(_ colorSchemeMode: Binding<ColorSchemeMode>) -> some View {
    let bool = colorSchemeMode.wrappedValue == .night
    
    
    nightModed(if: bool)
      .preferredColorScheme(colorSchemeMode.wrappedValue.resolvedColorScheme)
      .environment(\.colorSchemeMode, colorSchemeMode)
//      .colorScheme(colorSchemeMode.wrappedValue.value.resolvedColorScheme ?? colorScheme)
  }
  
  public func nightModed(if bool: Bool) -> some View {
    monochromed(if: bool, color: .red, colorScheme: .dark)
  }
}
