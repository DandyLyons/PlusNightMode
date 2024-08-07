
import SwiftUI

/// A key used to determine whether the View should differentiation without color.
struct ShouldDifferentiateWithoutColorKey: EnvironmentKey {
    
    static let defaultValue: Bool? = nil
}

extension EnvironmentValues {
    
    
    /// Communicates to this View whether it should differentiate without color.
    /// >Important: You do not set this value.
    /// >It will be set for you whenever you use PlusNightMode and your View is monochromed.
    ///
    /// This Environment value communicates to the View whether it should use color to convey
    /// information to the user.
    /// ## Purpose
    /// Not all users are able to distinguish between colors on screen.
    /// Therefore, to improve accessibility, Apple provides the "Differentiate without color" accessibility option in Settings.
    /// In order for apps to honor this setting, SwiftUI provides the `accessibilityDifferentiateWithoutColor` EnvironmentValue.
    ///
    /// PlusNightMode introduces and solves a similar problem. Because, Night Mode is a red on black appearance, it must be monochrome.
    /// But if a View is monochrome, then the user loses all ability to differentiate colors, because now the UI only has one color.
    ///
    /// For this reason, PlusNightMode offers the `shouldDifferentiateWithoutColor` Environment value.
    /// This value will factor in both, whether the View is currently monochromed, and the current value of `accessibilityDifferentiateWithoutColor`.
    /// ## Listening to whether a View should differentiate without color
    /// For best user experience, all of your Views should listen to, and honor the `shouldDifferentiateWithoutColor` Environment value. This way, your Views can know when to use shapes and glyphs rather than color to communicate to users.
    ///
    /// ## Migrating from accessibilityDifferentiateWithoutColor
    /// If you were already listening to `accessibilityDifferentiateWithoutColor` then simply switch to `shouldDifferentiateWithoutColor` like so.
    /// ```diff
    /// - @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
    /// + @Environment(\.shouldDifferentiateWithoutColor) var differentiateWithoutColor
    /// ```
    /// You will still receive the underlying value of `accessibilityDifferentiateWithoutColor`, plus
    /// now you'll know when your Views are monochromed by PlusNightMode. All other View logic should be unaffected.
    ///
    /// >Note: It will evaluate `accessibilityDifferentiateWithoutColor` at the time that
    /// >the View is first monochromed. In other words, it will not receive subsequent updates when the user
    /// changes "Differentiate without color" in their accessibility settings. However, users are unlikely to change this setting
    /// back and forth, and therefore this shouldn't be an issue in practice.
    ///
    public var shouldDifferentiateWithoutColor: Bool? {
        get { self[ShouldDifferentiateWithoutColorKey.self] }
        set { self[ShouldDifferentiateWithoutColorKey.self] = newValue }
    }
}

/// A view modifier that adjusts the differentiation without color settings.
@available(*, deprecated, message: "WIP Unfinished")
struct ShouldDifferentiateWithoutColorViewModifier: ViewModifier {
    @Environment(\.accessibilityDifferentiateWithoutColor) var accessibilityDifferentiateWithoutColor
    @Environment(\.shouldDifferentiateWithoutColor) var shouldDifferentiateWithoutColor
    
    /// Applies the differentiation without color settings to the content.
    ///
    /// This modifier assesses `accessibilityDifferentiateWithoutColor` at the time of the Views creation
    /// and does not respond to updates. However, users are not likely to change this setting on their device often,
    /// and so that should not be a problem.
    /// - Parameter content: The content to modify.
    /// - Returns: The modified content.
    func body(content: Content) -> some View {
        let differentiateWithoutColor = accessibilityDifferentiateWithoutColor ? true : shouldDifferentiateWithoutColor
        return content
            .environment(\.shouldDifferentiateWithoutColor, differentiateWithoutColor)
    }
}

extension View {

    func shouldDifferentiateWithoutColor() -> some View {
        self.modifier(ShouldDifferentiateWithoutColorViewModifier())
    }
}
