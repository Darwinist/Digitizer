//
//  TapView.m
//  Example
//
//  Created by Jonathan Cardasis (C) on 8/2/19.
//  Copyright © 2019 Jonathan Cardasis (C). All rights reserved.
//

#import "TapView.h"

@interface TapView ()
@property (nullable, nonatomic) NSMutableDictionary<NSString*,UIView*> *activeTapViews;
@end

@implementation TapView

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.activeTapViews = [[NSMutableDictionary alloc] init];
        self.indicatorColor = [UIColor purpleColor];
        [self setMultipleTouchEnabled:YES];
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInView:self];
        
        UIView *tapView = [self makeTapIndicatorView];
        tapView.center = location;
        tapView.transform = CGAffineTransformMakeScale(1.25, 1.25);
        [self addSubview:tapView];
        
        NSString *identifer = [NSString stringWithFormat:@"%lu", (unsigned long)touch.hash];
        self.activeTapViews[identifer] = tapView;
    }
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (UITouch* touch in touches) {
        CGPoint location = [touch locationInView:self];
        NSString *identifer = [NSString stringWithFormat:@"%lu", (unsigned long)touch.hash];
        UIView *tapView = self.activeTapViews[identifer];
        tapView.center = location;
    }
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    for (UITouch* touch in touches) {
        NSString *identifer = [NSString stringWithFormat:@"%lu", (unsigned long)touch.hash];
        UIView *tapView = self.activeTapViews[identifer];
        
        [UIView animateWithDuration:0.2 animations:^{
            tapView.transform = CGAffineTransformIdentity;
        }];
    }
    [self.activeTapViews removeAllObjects];
}

# pragma mark - Private

- (UIView*)makeTapIndicatorView {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    
    view.backgroundColor = [self.indicatorColor colorWithAlphaComponent:0.65];
    view.layer.borderColor = self.indicatorColor.CGColor;
    view.layer.borderWidth = 4.0;
    view.layer.cornerRadius = 12.0;
    
    return view;
}

@end
