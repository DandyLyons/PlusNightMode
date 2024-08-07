import SwiftUI

public struct ColorSchemeModeEnvironmentKeyModifier: ViewModifier {
  @Binding var mode: ColorSchemeMode
  
  public func body(content: Content) -> some View {
    content
      .preferredColorScheme(mode.value.resolvedColorScheme)
      .observingNightMode($mode)
  }
}

extension View {
  public func colorSchemeMode(_ mode: Binding<ColorSchemeMode>) -> some View {
    self.modifier(ColorSchemeModeEnvironmentKeyModifier(mode: mode))
  }
}
