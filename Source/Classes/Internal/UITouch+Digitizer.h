//
//  UITouch+Digitizer.h
//  Digitizer
//
//  Created by Jonathan Cardasis (C) on 8/2/19.
//  Copyright © 2019 Jonathan Cardasis (C). All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITouch (Digitizer)

- (id)initAtPoint:(CGPoint)point inWindow:(UIWindow*)window;

- (id)initAtPoint:(CGPoint)point inView:(UIView*)view;

/// Updates the touch's timestamp to the current system time.
- (void)updateTimestamp;

@end

NS_ASSUME_NONNULL_END
