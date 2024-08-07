# Getting Started


``PlusNightMode`` makes it easy to add dynamic, user-configurable appearance controls to any SwiftUI View. 


``PlusNightMode`` supports 4 appearance settings: 
1. ``ColorSchemeMode.Value.light``: A light mode appearance
2. ``ColorSchemeMode.Value.dark``: A dark mode appearance
3. ``ColorSchemeMode.Value.auto``: An appearance that will automatically switch between light and dark appearance according to the parent View's color scheme. (If every ancestor View has a color scheme that has not been overridden, then this appearance will follow the appearance of the device.)
4. ``ColorSchemeMode.Value.night``: A night mode appearance

## What's Night Mode
Night Mode is an appearance designed to aggressively reduce the amount of harmful, sleep-depriving blue light. It does this by a combination of these strategies: 
1. Under the hood, the night mode appearance will give every child SwiftUI View a dark SwiftUI color scheme. 
2. Then the Night Mode appearance will apply a red color multiply filter over the View. 

This effectively means that every pixel of View will be pitch black or a shade of red! 

## `ColorScheme` vs. `ColorSchemeMode` 
- SwiftUI has a type called [ColorScheme](https://developer.apple.com/documentation/swiftui/colorscheme): 
  - This only has support for light and dark mode. 
  - There's no support for auto or night. 
- PlusNightMode introduces a new type called ``ColorSchemeMode``: 
  - It adds support for auto and night appearance. 

## Adding Night Mode
The easiest way to add night mode is to use the ``nightModed(if:)`` method and pass it a value of `true`. This method will force the View (and all its children to have a night mode appearance). (However, it will pay no attention to users settings in the app, nor in device settings.)

```swift
@State var shouldNightMode = true
// ...
MyView()
  .nightModed(if: shouldNightMode)
```

But the best way to add night mode to your View is to use ``colorSchemeMode(_:)``. This will ensure that the SwiftUI View (and all its children) will dynamically update to match the user's current settings both in the app and in the device settings.

```swift
@Environment(\.colorSchemeMode) var colorSchemeMode
// ...
MyView()
  .colorSchemeMode($colorSchemeMode)
```
## Adding User Configurability
Now you can add the color scheme mode to your app's settings like this, and the changes will be visible across the app! 

```swift
// In your Settings Screen 
@Environment(\.colorSchemeMode) var colorSchemeMode
// ...
Picker("ColorSchemeMode", selection: $colorSchemeMode) {
  Text("Night").tag(ColorSchemeMode.night)
  Text("Dark").tag(ColorSchemeMode.dark)
  Text("Light").tag(ColorSchemeMode.light)
  Text("Auto").tag(ColorSchemeMode.auto)
}
.pickerStyle(.menu)
```

## On View Hierarchy
It is important to note that ``colorSchemeMode(_:)`` can only apply the night mode appearance to children views. It cannot apply the night mode appearance to parent or sibling views. Because of this, it is best practice to: 
1. Apply ``colorSchemeMode(_:)`` at the highest possible level of each View hierarchy. The higher the better, since only children will be affected. 
2. Reapply ``colorSchemeMode(_:)`` when creating a branching view hierarchy: 
  - Certain views such as view presentations, like SwiftUI's `.sheet` create an entirely new View hierarchy. For this you need to reapply ``colorSchemeMode(_:)`` to the presented View. 

```swift
struct ExampleView: View {
  @Environment(\.colorSchemeMode) var colorSchemeMode

  var body: some View {
    Button {
      isPresenting.toggle()
    } label: {
      Text("Present Sheet View")
    }
    .colorSchemeMode($colorSchemeMode)
    .sheet(isPresented: $isPresenting) {
      Text("Presented View")
        .colorSchemeMode($colorSchemeMode)
        // 👆🏼 SwiftUI will not add Night Mode to 
        // presented views unless you explicitly add it
    }
  }
}
```