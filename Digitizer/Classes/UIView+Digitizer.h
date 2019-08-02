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

/// Send a touch event to a point on the view, holding that touch for a duration of seconds.
- (void)simulateLongTouchAtPoint:(CGPoint)point duration:(NSTimeInterval)holdDuration;

/// Send a touch event to a point provided on the view.
- (void)simulateTouchAtPoint:(CGPoint)point;


@end

NS_ASSUME_NONNULL_END
