//
//  UIEvent+PrivateHeaders.h
//  Digitizer
//
//  Created by Jonathan Cardasis (C) on 8/2/19.
//  Copyright © 2019 Jonathan Cardasis (C). All rights reserved.
//

#ifndef UIEvent_PrivateHeaders_h
#define UIEvent_PrivateHeaders_h

#import "IOHIDEventRef.h"

@interface UIEvent (PrivateHeaders)
- (void)_addTouch:(UITouch *)touch forDelayedDelivery:(BOOL)arg2;
- (void)_clearTouches;
- (void)_setHIDEvent:(IOHIDEventRef)event;
- (void)_setTimestamp:(NSTimeInterval)timestemp;
@end


#endif /* UIEvent_PrivateHeaders_h */
