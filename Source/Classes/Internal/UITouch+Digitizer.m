//
//  UITouch+Digitizer.m
//  Digitizer
//
//  Created by Jonathan Cardasis (C) on 8/2/19.
//  Copyright © 2019 Jonathan Cardasis (C). All rights reserved.
//

#import "UITouch+Digitizer.h"
#import "IOHIDEvents.h"
#import "UITouch+PrivateHeaders.h"

@implementation UITouch (Digitizer)

- (id)initAtPoint:(CGPoint)point inWindow:(UIWindow*)window {
    self = [super init];
    if (self) {
        [self setWindow:window];
        
        [self setTapCount:1];
        [self _setLocationInWindow:point resetPrevious:YES];
        
        UIView *hitTestView = [window hitTest:point withEvent:nil];
        
        [self setView:hitTestView];
        [self setPhase:UITouchPhaseBegan];
        [self _setIsFirstTouchForView:YES];
        [self setIsTap:YES];
        [self setTimestamp:[[NSProcessInfo processInfo] systemUptime]];
        
        if ([self respondsToSelector:@selector(setGestureView:)]) {
            [self setGestureView:hitTestView];
        }
        
        [self setIOHIDEvent];
    }
    
    return self;
}

- (id)initAtPoint:(CGPoint)point inView:(UIView*)view {
    UIWindow *window = view.window;
    return [self initAtPoint:[window convertPoint:point fromView:view] inWindow:window];
}

# pragma mark - Private

- (void)setIOHIDEvent {
    IOHIDEventRef event = IOHIDEventWithTouches(@[self]);
    [self _setHidEvent:event];
    CFRelease(event);
}

@end
