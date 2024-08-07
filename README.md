# PlusNightMode
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FDandyLyons%2FPlusNightMode%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/DandyLyons/PlusNightMode)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FDandyLyons%2FPlusNightMode%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/DandyLyons/PlusNightMode)

PlusNightMode makes it easy for your app to add user-configurable light mode, dark mode, automatic (OS Setting), and night mode. It is designed to work with SwiftUI.

<img src="https://raw.githubusercontent.com/DandyLyons/PlusNightMode/main/README/Example.GIF">

## Sections
- [What is night mode?](#what-is-night-mode)
- [Usage](#usage)
- [ColorSchemeMode](#colorschememode)
- [Known Limitations](#known-limitations)
- [Design Considerations](#design-considerations)
- [Collaboration](#collaboration)
- [Thank Yous](#thank-yous)

## What is night mode?

It has long been known that exposure to light at night decreases our bodies' production of melatonin. In WWDC 23, Apple unveiled an innovative approach to tackling this problem, "Night Mode". It's a UI visual appearance that is "red-scale", meaning every single pixel on the screen is either black, or a shade of red. This is valuable for 2 main reasons. Overall less light is shown. Second, blue light (which has the most negative impact on melatonin production) is filtered out. However, currently, Apple's Night Mode is only available iOS 17's StandBy, and one single watch face. Now you can add night mode to your app with a few lines of code.

In other words, Night Mode protects your users from health hazardous, sleep-depriving light.

## Usage
Simply add `.observingNightMode()` to the very top of your View hierarchy like so:

```swift
struct NightModeView: View {
    @State private var isNightModeOn = true // 👈🏼

    var body: some View {
      NavigationStack {
        List {
          Image(.blindingWhite)
            .resizable()
            .frame(maxWidth: .infinity)
            .aspectRatio(1.0, contentMode: .fill)
          Text("This is a text view")
          Text("Blue").foregroundStyle(.blue)
          Text("Green").foregroundStyle(.green)
          Text("Yellow").foregroundStyle(.yellow)
          NavigationLink("Go to second page", value: "second page")
        }
        .navigationTitle("Hello World!")
        .navigationDestination(for: String.self) { string in
          Text(string)
        }
      }
      .observingNightMode(isNightModeOn) // 👈🏼
    }
}
```
This will turn that View and all of it's child views into night mode.

Please note, presented views are not considered to be child views by SwiftUI. Therefore whenever you present a View (for example in a `.sheet`) you must apply `.observingNightMode()` to that presented View as well.

```swift
struct ExampleView: View {
  @State private var isPresenting = false

  var body: some View {
    Button {
      isPresenting.toggle()
    } label: {
      Text("Present Sheet View")
    }
    .sheet(isPresented: $isPresenting) {
      Text("Presented View")
        .observingNightMode(true) 
        // 👆🏼 SwiftUI will not add Night Mode to 
        // presented views unless you explicitly add it
    }
  }
}
```
🚀 But there's an even better way to add night mode, that even responds to the device's current dark mode settings. It's called **ColorSchemeMode**.

### ColorSchemeMode

PlusNightMode also comes with `ColorSchemeMode`, a simple wrapper struct that adds some functionality to SwiftUI's [ColorScheme](https://developer.apple.com/documentation/swiftui/colorscheme), including night mode. To use, simply create and store a `ColorSchemeMode` somewhere in your model. Then set `.colorSchemeMode()` at the top of your View hierarchy.

```swift
struct ExampleView: View {
  @State var colorSchemeMode: ColorSchemeMode = .night


  var body: some View {
    Text("Hello world")
      .colorSchemeMode($colorSchemeMode)
  }
}
```

`ColorSchemeMode` can have the following values: 
- `night`: A monochrome red on black presentation
- `dark`: Dark mode
- `light`: Light mode
- `auto`: Automatically adjust to the device's current light/dark mode setting. 

## Known Limitations

We can only apply night mode to views within the SwiftUI View hierarchy. This does not include system views such as the status bar at the top of the screen.

Certain SwiftUI Views cannot be styled or overlayed. For example, when a user taps a SwiftUI `Menu`. Notice how the presented menu is in dark mode, not in night mode. If you find a workaround please open an Issue or PR.

<img src="https://raw.githubusercontent.com/DandyLyons/PlusNightMode/main/README/Non-Night%20Mode%20Menu.jpeg"  width="200" >

## Design Considerations

Be sure to test your design in all use cases. Some things to look out for:

- Night Mode will of course filter out blue light (that's the whole point of it). For this reason, blue elements can become invisible or difficult to see.
- Since Night Mode is monochrome, your UI cannot use color to communicate to the user. Therefore, it's recommended to:
  - Add the SwiftUI enironment value [accessibilityDifferentiateWithoutColor](https://developer.apple.com/documentation/swiftui/environmentvalues/accessibilitydifferentiatewithoutcolor) to tell all child views when they need to use shapes, rather than colors to communicate to the user. (In an upcoming release PlusNightMode will handle this automatically.)
  - Add simple logic for child views to respect accessibilityDifferentiateWithoutColor. *Hacking with Swift* has a very helpful [tutorial](https://www.hackingwithswift.com/books/ios-swiftui/supporting-specific-accessibility-needs-with-swiftui) on this subject.

## Collaboration

Please feel free to open a PR.

## Thank Yous
- [Swift Package Index](https://swiftpackageindex.com/) for mentioning us in their [podcast episode](https://podcasts.apple.com/us/podcast/39-stress-testing-dependency-management/id1654567329?i=1000641328907) (at 26:00). 