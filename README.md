# DigitizerIO


## Abstract
Hijack I/O Kit to dispatch touches events to the iOS digitizer.

Autonomously send events to the iOS digitizer. Useful for testing and automation.

- Send touch events to `UIView`'s by reference or by `accessibilityID`


#### App Store
_DigitizerIO requires iOS10+ and should not be included in App Store binaries._

DigitizerIO uses IOHID, part of the I/O Kit framework. Although I/O Kit is a public framework, Apple states any apps using it will be rejected from the App Store.

#### I/O Kit Headers
The IOKit headers were removed from the iOS SDK a few versions ago. However, they can be found in the Mac OS SDK:
```
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks/IOKit.framework/Versions/A/Headers
```