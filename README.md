# swiftui-hosting-transitions

[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fpbalduz%2Fswiftui-hosting-transitions%2Fbadge%3Ftype%3Dswift-versions)](https://swiftpackageindex.com/pbalduz/swiftui-hosting-transitions)
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2Fpbalduz%2Fswiftui-hosting-transitions%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/pbalduz/swiftui-hosting-transitions)

`SwiftUI` enables to perform smooth transitions between views using [`matchedGeometryEffect`](https://developer.apple.com/documentation/swiftui/view/matchedgeometryeffect(id:in:properties:anchor:issource:)) view modifier but what happens when the views are contained in `UIHostingControllers`? 

When transitioning `UIKit` projects to `SwiftUI`, many developers initially wrap their views in `UIHostingController`s while keeping navigation in `UIKit`. However, this approach limits the ability to implement custom transitions between the `SwiftUI` views. This library addresses this challenge by providing a straightforward solution for executing custom matched geometry transitions specifically designed for `UIHostingController`s.

During the development of this repository was inspired by and article about view controller transitions in `SwiftUI`.

> [A Hero View Controller Transition in SwiftUI](https://shadowfacts.net/2023/swiftui-hero-transition/)

## Installation

### [Swift Package Manager](https://swift.org/package-manager/)

If you want to use Matched Transitions in an SPM project, just add it to the `dependencies` in your `Package.swift`:

```swift
dependencies: [
  .package(url: https://github.com/pbalduz/swiftui-hosting-transitions, from: "0.1.0")
]
```

Then, you can include in any target as a dependency:

```swift
targets: [
  .target(
    name: "MyTarget",
    dependencies: [
      .product(name: "MatchedTransitions", package, "swiftui-hosting-transitions")
    ]
]
```

You can also add it to and Xcode project by adding it as a package dependency.

### [CocoaPods](http://cocoapods.org)

To install `swiftui-hosting-transitions`, simply add the following line to your Podfile:
```ruby
pod 'swiftui-hosting-transitions'
```

## Usage

The API to perform custom transitions is pretty simple and requires of two steps, identifying the `SwiftUI` views that should animate (source and destination) and wrapping the views' in a `MatchedHostingController`.

This is how the views to animate are identified:

```swift
struct FirstView: View {
  var body: some View {
    Color.red
      .frame(width: 100, height: 100)
      .matchedGeometry(id: "id", isSource: true)
  }
}

struct SecondView: View {
  var body: some View {
    Color.red
      .frame(maxWidth: .infinity)
      .frame(height: 100)
      .matchedGeometry(id: "id", isSource: false)
  }
}
```

Then we would just need to wrap the views in `MatchedHostingController`s instead of `UIHostingController`:

```swift
class FirstViewController: MatchedHostingController<FirstView> {
  let state = MatchedGeometryState()
  
  init() {
    super.init(
      rootView: FirstView(),
      state: state
    )
  }
}

class SecondViewController: MatchedHostingController<SecondView> {
  init(state: MatchedGeometryState) {
    super.init(
      rootView: SecondView(),
      state: state
    )
  }
}
```

`MatchedHostingController` inherits from `UIHostingController` and retains a similar initialization API, with the addition of a `state` property crucial for the proper execution of transitions. It is essential to retain an instance of this property, as it must be passed to the destination view controller to enable the sharing of information about matched views.

Finally, in order to navigate between view controllers the regular navigation controller API can be used:

```swift
// from FirstViewController
let vc = SecondViewController(state: state)
navigationController?.pushViewController(vc, animated: true)
```

### Demo

![matched-transition-demo](https://github.com/pbalduz/swiftui-hosting-transitions/assets/9513953/489e9f20-297e-4eca-8ba6-ea07c9dd7f51)


## What's next
* Currently, only push navigation is supported and modal presentation is still to be implemented.
* Interactive transitions?
* MacOS navigation support?
* Background transition for non matched views has a small weird opacity change when background is not white that should be addressed.
