//
//  FakeView.m
//  Digitizer
//
//  Created by Jonathan Cardasis (C) on 8/5/19.
//  Copyright © 2019 Jonathan Cardasis (C). All rights reserved.
//

#import "FakeView.h"

@implementation FakeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setUserInteractionEnabled:YES];
        [self setMultipleTouchEnabled:YES];
        
        self.beginTouches = [[NSSet alloc] init];
        self.movedTouches = [[NSSet alloc] init];
        self.endedTouches = [[NSSet alloc] init];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    self.beginTouches = touches;
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.movedTouches = touches;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.endedTouches = touches;
}

@end
