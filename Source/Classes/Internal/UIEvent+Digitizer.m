//
//  UIEvent+Digitizer.m
//  Digitizer
//
//  Created by Jon Cardasis on 8/4/19.
//  Copyright © 2019 Jonathan Cardasis (C). All rights reserved.
//

#import "UIEvent+Digitizer.h"
#import "UIEvent+PrivateHeaders.h"
#import "UIApplication+PrivateHeaders.h"
#import "IOHIDEvents.h"

@implementation UIEvent (Digitizer)

+ (id)eventFromTouches:(NSArray<UITouch*>*)touches {
    UIEvent *event = [[UIApplication sharedApplication] _touchesEvent];
    
    // Clean up before injecting touches
    [event _clearTouches];
    
    IOHIDEventRef touchHIDEvent = IOHIDEventWithTouches(touches);
    [event _setHIDEvent:touchHIDEvent];
    CFRelease(touchHIDEvent);
    
    for (UITouch *touch in touches) {
        [event _addTouch:touch forDelayedDelivery:NO];
    }
    
    return event;
}

@end
