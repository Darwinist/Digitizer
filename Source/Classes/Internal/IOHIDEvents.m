//
//  IOHID_private.m
//  Digitizer
//
//  Created by Jonathan Cardasis (C) on 8/2/19.
//  Copyright © 2019 Jonathan Cardasis (C). All rights reserved.
//

#import "IOHIDEvents.h"
#import <mach/mach_time.h>
#import "IOHIDEventData.h"
#import "UIApplication+PrivateHeaders.h"
#import "UITouch+PrivateHeaders.h"

// Method signatures from iOS3.0 extracted headers
extern void IOHIDEventAppendEvent(IOHIDEventRef event, IOHIDEventRef childEvent);
extern void IOHIDEventSetIntegerValue(IOHIDEventRef event, IOHIDEventField field, int value);
extern void IOHIDEventSetSenderID(IOHIDEventRef event, uint64_t sender);
extern IOHIDEventRef IOHIDEventCreateDigitizerEvent(CFAllocatorRef allocator, AbsoluteTime timeStamp, IOHIDDigitizerTransducerType type, uint32_t index, uint32_t identity, uint32_t eventMask, uint32_t buttonMask, IOHIDFloat x, IOHIDFloat y, IOHIDFloat z, IOHIDFloat tipPressure, IOHIDFloat barrelPressure, Boolean range, Boolean touch, IOOptionBits options);
extern IOHIDEventRef IOHIDEventCreateDigitizerFingerEventWithQuality(CFAllocatorRef allocator, AbsoluteTime timeStamp, uint32_t index, uint32_t identity, uint32_t eventMask, IOHIDFloat x, IOHIDFloat y, IOHIDFloat z, IOHIDFloat tipPressure, IOHIDFloat twist, IOHIDFloat minorRadius, IOHIDFloat majorRadius, IOHIDFloat quality, IOHIDFloat density, IOHIDFloat irregularity, Boolean range, Boolean touch, IOOptionBits options);


IOHIDEventRef IOHIDEventWithTouches(NSArray<UITouch*>* touches) {
    uint64_t absoluteTime = mach_absolute_time();
    
    AbsoluteTime timestamp;
    timestamp.hi = (UInt32)(absoluteTime >> 32);
    timestamp.lo = (UInt32)(absoluteTime);
    
    IOHIDEventRef digitizerEvent = IOHIDEventCreateDigitizerEvent(kCFAllocatorDefault, // allocator
                                                                  timestamp, // timestamp
                                                                  kIOHIDDigitizerTransducerTypeHand,// type
                                                                  0, // index
                                                                  0, // identity
                                                                  kIOHIDDigitizerEventTouch, // eventMask
                                                                  0,// button mask
                                                                  0, // x
                                                                  0, // y
                                                                  0, // z
                                                                  0, // tipPressure
                                                                  0, // barrelPressure
                                                                  0, // range
                                                                  true, //touch
                                                                  0); // options
    
    IOHIDEventSetIntegerValue(digitizerEvent, kIOHIDEventFieldDigitizerIsDisplayIntegrated, true);
    
    [touches enumerateObjectsUsingBlock:^(UITouch *touch, NSUInteger idx, BOOL *stop) {        
        // Simulate touch on the digitizer
        uint32_t eventMask = touch.phase == UITouchPhaseMoved ? kIOHIDDigitizerEventPosition : (kIOHIDDigitizerEventRange | kIOHIDDigitizerEventTouch);
        uint32_t isRangeAndTouch = touch.phase == UITouchPhaseEnded ? 0 : 1;
        
        CGPoint touchLocation = [touch locationInView:touch.window];
        
        IOHIDEventRef touchEvent = IOHIDEventCreateDigitizerFingerEventWithQuality(kCFAllocatorDefault, // allocator
                                                                                   timestamp, // timestamp
                                                                                   (UInt32)idx, // index
                                                                                   2, // identity
                                                                                   eventMask, // eventMask
                                                                                   (IOHIDFloat)touchLocation.x, // x
                                                                                   (IOHIDFloat)touchLocation.y, // y
                                                                                   0, // z
                                                                                   0, // tipPressure
                                                                                   0, // twist
                                                                                   5.0, // minorRadius
                                                                                   5.0, // majorRadius
                                                                                   1.0,// quality
                                                                                   1.0, // density
                                                                                   1.0, // irregularity
                                                                                   (IOHIDFloat)isRangeAndTouch, // range
                                                                                   (IOHIDFloat)isRangeAndTouch, // touch
                                                                                   0); // options
        
        IOHIDEventSetIntegerValue(touchEvent, kIOHIDEventFieldDigitizerIsDisplayIntegrated, 1);
        
        IOHIDEventAppendEvent(digitizerEvent, touchEvent);
        CFRelease(touchEvent);
    }];
    
    return digitizerEvent;
}
