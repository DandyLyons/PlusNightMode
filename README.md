# PlusNightMode

PlusNightMode makes it easy for your app to add user-configurable light mode, dark mode, automatic (OS Setting), and night mode. It is designed to work with SwiftUI. 

## What is night mode? 

It has long been known that exposure to light at night decreases our bodies' production of melatonin. In WWDC 23, Apple unveiled an innovative approach to tackling this problem, "Night Mode". It's a UI visual appearance that is "red-scale", meaning every single pixel on the screen is either black, or a shade of red. This is valuable for 2 main reasons. Overall less light is shown. Second, blue light (which has the most negative impact on melatonin production) is filtered out. However, currently, Apple's Night Mode is only available iOS 17's StandBy, and one single watch face. Now you can add night mode to your app with a few lines of code. 

In other words, Night Mode protects your users from health hazardous, sleep-depriving light. 

## Usage

Simply add `.observingNightMode()` to the very top of your View hierarchy like so: 

```swift
struct NightModeView: View {
    @State private var isNightModeOn = true

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
      .observingNightMode(isNightModeOn)
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
    }
  }
}
```
### ColorSchemeMode

PlusNightMode also comes with `ColorSchemeMode`, a simple wrapper struct that adds some functionality to SwiftUI's [ColorScheme](https://developer.apple.com/documentation/swiftui/colorscheme) including night mode. To use, simply create and store a `ColorSchemeMode` somewhere in your model. Then set your preferredColorScheme in SwiftUI. 

```swift
struct ExampleView: View {
  let colorSchemeMode: ColorSchemeMode
  
  var body: some View {
    Text("Hello world")
      .preferredColorScheme(colorSchemeMode.resolvedColorScheme)
  }
}
```
## Known Limitations

We can only apply night mode to views within the SwiftUI View hierarchy. This does not include system views such as the status bar at the top of the screen. 

Certain SwiftUI Views cannot be styled or overlayed. For example, when a user taps a SwiftUI `Menu`. 

<img src="https://raw.githubusercontent.com/DandyLyons/PlusNightMode/main/README/Non-Night%20Mode%20Menu.jpeg"  width="200" >

## Design Considerations

Be sure to test your design in all use cases. Some things to look out for: 

- Night Mode will of course filter out blue light (that's the whole point of it). For this reason, blue elements can become invisible or difficult to see. 
