//
//  UIControl+Testing.m
//  DigitizerTests
//
//  Created by Jonathan Cardasis (C) on 8/5/19.
//  Copyright © 2019 Jonathan Cardasis (C). All rights reserved.
//

#import "UIControl+Testing.h"

@implementation UIControl (Testing)

/**
 UIControlEvents has bitmap sets in ranges: [0-8], [12-13], [16-19]. If new options are added after 19, this constant will need to be updated.
  */
static NSUInteger const UIControlEventsCount = 19;

- (void)mock_sendActionsForControlEvents:(UIControlEvents)controlEvents {
    for (NSUInteger i=0; i < UIControlEventsCount; i++) {
        UIControlEvents controlEvent = 1 << i;
        if (controlEvents & controlEvent) {
            for (id target in self.allTargets) {
                NSArray<NSString*> *targetActions = [self actionsForTarget:target forControlEvent:controlEvent];
                for (NSString *action in targetActions) {
                    SEL selector = NSSelectorFromString(action);
                    IMP imp = [target methodForSelector:selector];
                    void (*targetFunc)(id, SEL, id) = (void*)imp;
                    targetFunc(target, selector, self);
                }
            }
        }
    }
}

@end
