//
//  UIView+Digitizer.m
//  Digitizer
//
//  Created by Jonathan Cardasis (C) on 8/1/19.
//  Copyright © 2019 Jonathan Cardasis (C). All rights reserved.
//

#import "UIView+Digitizer.h"
#import "UITouch+Digitizer.h"
#import "IOHIDEvents.h"
#import "UIApplication+PrivateHeaders.h"
#import "UIEvent+PrivateHeaders.h"
#import "UITouch+PrivateHeaders.h"

@implementation UIView (Digitizer)

- (void)simulateLongTouchAtPoint:(CGPoint)point duration:(NSTimeInterval)holdDuration {
    [self dispatchTouchAtPoint:point holdDuration:holdDuration];
}

- (void)simulateTouchAtPoint:(CGPoint)point {
    [self dispatchTouchAtPoint:point holdDuration:0];
}

# pragma mark - Private

- (void)dispatchTouchAtPoint:(CGPoint)point holdDuration:(NSTimeInterval)duration {
    UITouch *touch = [[UITouch alloc] initAtPoint:point inView:self];
    
    [touch updateTimestamp];
    [touch setPhase:UITouchPhaseBegan];
    
    UIEvent *event = [self eventFromTouch:touch];
    
    // Dispatch Began phase
    [[UIApplication sharedApplication] sendEvent:event];
    
    void (^dispatchTouchEnd)(void) = ^{
        [touch updateTimestamp];
        [touch setPhase:UITouchPhaseEnded];
        [[UIApplication sharedApplication] sendEvent:event];
        
        // Update self to first responder manually since dispatching event through UIApplication doesn't update it.
        if ([touch.view isDescendantOfView:self] && [self canBecomeFirstResponder]) {
            [self becomeFirstResponder];
        }
    };
    
    // Dispatch End phase
    if (duration == 0) {
        dispatchTouchEnd();
    } else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), dispatchTouchEnd);
    }
}


- (UIEvent*)eventFromTouch:(UITouch*)touch {
    UIEvent *event = [[UIApplication sharedApplication] _touchesEvent];
    
    // Clean up before injecting touches
    [event _clearTouches];
    
    IOHIDEventRef touchHIDEvent = IOHIDEventWithTouches(@[touch]);
    [event _setHIDEvent:touchHIDEvent];
    CFRelease(touchHIDEvent);
    
    [event _addTouch:touch forDelayedDelivery:NO];
    
    return event;
}

@end
