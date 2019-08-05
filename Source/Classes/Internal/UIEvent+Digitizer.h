//
//  UIEvent+Digitizer.h
//  Digitizer
//
//  Created by Jon Cardasis on 8/4/19.
//  Copyright © 2019 Jonathan Cardasis (C). All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIEvent (Digitizer)

+ (id)eventFromTouches:(NSArray<UITouch*>*)touches;

@end

NS_ASSUME_NONNULL_END
