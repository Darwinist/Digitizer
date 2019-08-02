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

- (void)simulateLongTouchAtPoint:(CGPoint)point holdDuration:(NSTimeInterval)holdDuration {
    [self dispatchTouchsAtPoints:@[[NSNumber valueWithCGPoint:point]] holdDuration:holdDuration];
}

- (void)simulateTouchAtPoint:(CGPoint)point {
    [self dispatchTouchsAtPoints:@[[NSNumber valueWithCGPoint:point]] holdDuration:0];
}

- (void)simulateTouchesAtPoints:(NSArray<NSValue*>*)points {
    [self dispatchTouchsAtPoints:points holdDuration:0];
}

- (void)simulateTouchesAtPoints:(NSArray<NSValue*>*)points holdDuration:(NSTimeInterval)holdDuration {
    [self dispatchTouchsAtPoints:points holdDuration:holdDuration];
}

# pragma mark - Private

- (void)dispatchTouchsAtPoints:(NSArray<NSValue*>*)points holdDuration:(NSTimeInterval)duration {
    NSMutableArray *touches = [[NSMutableArray alloc] init];
    
    for (NSValue *value in points) {
        CGPoint point = [value CGPointValue];
        UITouch *touch = [[UITouch alloc] initAtPoint:point inView:self];
        
        [touch updateTimestamp]; // TODO: Make the timestamp occur before the for-loop so all touches have exact same timestamp.
        [touch setPhase:UITouchPhaseBegan];
        [touches addObject:touch];
    }
    
    UIEvent *event = [self eventFromTouches:touches];
    
    // Dispatch Began phase
    [[UIApplication sharedApplication] sendEvent:event];
    
    void (^dispatchTouchEnd)(void) = ^{
        for (UITouch *touch in touches) {
            [touch updateTimestamp]; // TODO: Make the timestamp occur before the for-loop so all touches have exact same timestamp.
            [touch setPhase:UITouchPhaseEnded];
            
            // Update self to first responder manually since dispatching event through UIApplication doesn't update it.
            if ([touch.view isDescendantOfView:self] && [self canBecomeFirstResponder]) {
                [self becomeFirstResponder];
            }
        }
        
        [[UIApplication sharedApplication] sendEvent:event];
    };
    
    // Dispatch End phase
    if (duration == 0) {
        dispatchTouchEnd();
    } else {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), dispatchTouchEnd);
    }
}

- (UIEvent*)eventFromTouches:(NSArray<UITouch*>*)touches { // TODO: Should probably just make a custom UIEvent::init
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
