//
//  UITouch+PrivateHeaders.h
//  Digitizer
//
//  Created by Jonathan Cardasis (C) on 8/2/19.
//  Copyright © 2019 Jonathan Cardasis (C). All rights reserved.
//

#ifndef UITouch_PrivateHeaders_h
#define UITouch_PrivateHeaders_h

#import "IOHIDEventRef.h"

@interface UITouch (PrivateHeaders)
- (void)setWindow:(UIWindow *)window;
- (void)setView:(UIView *)view;
- (void)setTapCount:(NSUInteger)tapCount;
- (void)setIsTap:(BOOL)isTap;
- (void)setTimestamp:(NSTimeInterval)timestamp;
- (void)setPhase:(UITouchPhase)touchPhase;
- (void)setGestureView:(UIView *)view;
- (void)_setLocationInWindow:(CGPoint)location resetPrevious:(BOOL)resetPrevious;
- (void)_setIsFirstTouchForView:(BOOL)firstTouchForView;
- (void)_setHidEvent:(IOHIDEventRef)event;
@end

#endif /* UITouch_PrivateHeaders_h */
