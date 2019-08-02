# DigitizerIO
Hijack I/O Kit to simulate touches events on the iOS digitizer.

Autonomously send events to the iOS digitizer. Useful for testing and automation.

### Features
- Send touch events to `UIView`'s by reference or by `accessibilityID`

### Usage
//TODO

### Swift Usage
//TODO

### Installation
DigitizerIO requires IOKit.framework, which is not located with iOS system frameworks. To link it, add `-framework IOKit` to _Other Linker Flags_ under _Build Settings_ of your target using DigitizerIO.


### App Store
_DigitizerIO should not be included in App Store builds._

DigitizerIO uses IOHID, part of the I/O Kit framework. Although I/O Kit is a public framework, Apple states any apps using it will be rejected from the App Store.
