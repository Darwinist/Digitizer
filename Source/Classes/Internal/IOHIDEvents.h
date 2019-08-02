//
//  IOHIDEvents.h
//  Digitizer
//
//  Created by Jonathan Cardasis (C) on 8/1/19.
//  Copyright © 2019 Jonathan Cardasis (C). All rights reserved.
//

#ifndef IOHIDEvents_private_h
#define IOHIDEvents_private_h

#import <UIKit/UIKit.h>
#import "IOHIDEventRef.h"

// NOTE: I had to add "-framework IOKit" to out Other Linker Flags

IOHIDEventRef IOHIDEventWithTouches(NSArray<UITouch*>* touches) CF_RETURNS_RETAINED;

#endif
