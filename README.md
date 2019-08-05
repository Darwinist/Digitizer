<p align="center">
    <img src=".github/Logo.png" width="800" alt="Digitizer" />
</p>

<p align="center">
  <img src="https://img.shields.io/badge/platform-iOS 10+-lightgray.svg" />
  <img src="https://img.shields.io/badge/license-MIT-blue.svg" />
  <img src="https://img.shields.io/badge/Carthage-compatible-green.svg" />
</p>

Hijack I/O Kit to simulate touches events on the iOS digitizer. Useful in UI testing and automation.

### Features
Send touch events to `UIView` by reference. Supports **single-touch**, **multitouch**, and **long press**.

```Objective-C
#import <Digitizer/Digitizer.h>
...
UIView *myView = [[UIView alloc] initWithFrame: CGRectMake(...)];

NSArray *points = @[
                     [NSValue valueWithCGPoint:CGPointMake(0, 0)],
                     [NSValue valueWithCGPoint:CGPointMake(myView.center.x, myView.center.y)]
                     ];

// Simulate touches
[myView simulateMultiTouchAtPoints:points holdDuration:2.0];
```

> Note: All touch simulations are serial actions and do not occur on a background thread. Simulating a touch will occur immediately and can be seen by placing a breakpoint on the touchesBegan:withEvent: function of the view.

### App Store Rejection
_Digitizer should not be included in App Store builds._

Digitizer uses IOHIDFamily classes, part of the I/O Kit framework. Although I/O Kit is a public framework, Apple states any apps using it will be rejected from the App Store.
