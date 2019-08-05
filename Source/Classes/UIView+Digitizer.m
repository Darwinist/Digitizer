//
//  UIView+Digitizer.m
//  Digitizer
//
//  Created by Jonathan Cardasis (C) on 8/1/19.
//  Copyright © 2019 Jonathan Cardasis (C). All rights reserved.
//

#import "UIView+Digitizer.h"
#import "UITouch+Digitizer.h"
#import "UIEvent+Digitizer.h"
#import "IOHIDEvents.h"
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
    NSTimeInterval now = [[NSProcessInfo processInfo] systemUptime];
    
    for (NSValue *value in points) {
        CGPoint point = [value CGPointValue];
        UITouch *touch = [[UITouch alloc] initAtPoint:point inView:self];
        
        [touch setTimestamp:now];
        [touch setPhase:UITouchPhaseBegan];
        [touches addObject:touch];
    }
    
    UIEvent *event = [UIEvent eventFromTouches:touches];
    
    // Dispatch Began phase
    [[UIApplication sharedApplication] sendEvent:event];
    
    void (^dispatchTouchEnd)(void) = ^{
        NSTimeInterval now = [[NSProcessInfo processInfo] systemUptime];
        
        for (UITouch *touch in touches) {
            [touch setTimestamp:now];
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

@end
