### I/O Kit Headers
The I/O Kit headers were removed from the iOS SDK a few versions ago. The _public_ ones can still be found in the Mac OS SDK:
```
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk/System/Library/Frameworks/IOKit.framework/Versions/A/Headers
```

The _private_ headers are a bit harder to track down, but Apple does have them open sourced [here](https://opensource.apple.com/source/IOHIDFamily/IOHIDFamily-870.60.4/IOHIDFamily/).

Only a subset of the I/O Kit is needed for digitizer event handling, so a minimum number of files are required.

### UIKit Headers
Headers extracted via classdump.
