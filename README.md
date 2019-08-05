<p align="center">
    <img src=".github/Logo.png" width="500" max-width="90%" alt="ChromaColorPicker 2.0" />
</p>

<p align="center">
  <img src="https://img.shields.io/badge/platform-iOS-lightgray.svg" />
  <img src="https://img.shields.io/badge/license-MIT-blue.svg" />
  <img src="https://img.shields.io/badge/Carthage-compatible-green.svg" />
</p>

Hijack I/O Kit to simulate touches events on the iOS digitizer.

### App Store Rejection
:warning: _Digitizer should not be included in App Store builds._ :warning:

Digitizer uses IOHIDFamily classes, part of the I/O Kit framework. Although I/O Kit is a public framework, Apple states any apps using it will be rejected from the App Store.

### Features
- Send touch events to `UIView`'s by reference or by `accessibilityID`

### Usage
```Objective-C
// TODO:
```

##### Swift Usage
```Swift
// TODO:
```

### Installation
Digitizer requires IOKit.framework, which is not located with iOS system frameworks. To link it, add `-framework IOKit` to _Other Linker Flags_ under _Build Settings_ of your target using Digitizer.
