//
//  UIControl+Testing.h
//  DigitizerTests
//
//  Created by Jonathan Cardasis (C) on 8/5/19.
//  Copyright © 2019 Jonathan Cardasis (C). All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIControl (Testing)

/**
 Test bundles with no host app will not send UIControl actions.
 
 This replacement for sendActionsForControlEvents: performs similar logic of invoking control events on an assigned target.
 */
- (void)mock_sendActionsForControlEvents:(UIControlEvents)controlEvents;

@end
