//
//  UIView+Digitizer.h
//  Digitizer
//
//  Created by Jonathan Cardasis (C) on 8/1/19.
//  Copyright © 2019 Jonathan Cardasis (C). All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Digitizer)

/**
 Send a touch event to a point on the view, holding that touch for a duration of seconds.
 
 @param point A point on the view to simulate a tap at.
 @param holdDuration Duration in seconds for the touch to be held.
 */
- (void)simulateLongTouchAtPoint:(CGPoint)point holdDuration:(NSTimeInterval)holdDuration;


/**
 Send a touch event to a point provided on the view.
 
 @param point A point on the view to simulate a tap at.
 */
- (void)simulateTouchAtPoint:(CGPoint)point;


/**
 Send touch events for multiple points at the same time.
 
 @param points An array of CGPoints.
 */
- (void)simulateMultiTouchAtPoints:(NSArray<NSValue*>*)points;


/**
 Send touch events for multiple points at the same time.
 
 @param points An array of CGPoints.
 @param holdDuration Duration in seconds for the touch to be held.
 */
- (void)simulateMultiTouchAtPoints:(NSArray<NSValue*>*)points holdDuration:(NSTimeInterval)holdDuration;

@end

NS_ASSUME_NONNULL_END
