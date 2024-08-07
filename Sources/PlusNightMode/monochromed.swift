import SwiftUI

extension View {
  
    
    /// Converts the appearance of a View to a monochrome appearance.
    ///
    /// Also injects the `shouldDifferentiateWithoutColor` Environment variable
    /// so that child views know that they must not use color to communicate to the user.
    /// - Parameters:
    ///   - bool: Whether the View should be monochromed
    ///   - color: What color the View should be monochromed to
    ///   - colorScheme: The light/dark mode appearance
    /// - Returns: The monochromed View. 
  public func monochromed(if bool: Bool, color: Color, colorScheme: ColorScheme) -> some View {
      
    let filter: some View = color
      .blendMode(bool ? .color : .normal)
      .opacity(bool ? 0.5 : 0.0)
      .allowsHitTesting(false)
      .ignoresSafeArea()
//      .shouldDifferentiateWithoutColor()
    
    return self
      .preferredColorScheme(bool ? colorScheme : nil)
      .tint(bool ? color : nil)
      .overlay {
        filter
      }
      .colorMultiply(bool ? color : .white)
  }
}
