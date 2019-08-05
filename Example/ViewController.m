//
//  ViewController.m
//  Example
//
//  Created by Jonathan Cardasis (C) on 8/2/19.
//  Copyright © 2019 Jonathan Cardasis (C). All rights reserved.
//

#import "ViewController.h"
#import "TapView.h"
#import <Digitizer/Digitizer.h>

@interface ViewController ()
@property (nonatomic, strong) UIColor *userTapColor;
@property (nonatomic, strong) UIColor *simulatedTapColor;
@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    NSArray *points = @[
                     [NSValue valueWithCGPoint:CGPointMake(100, 200)],
                     [NSValue valueWithCGPoint:CGPointMake(200, 200)],
                     [NSValue valueWithCGPoint:CGPointMake(300, 200)]
                     ];
    
    self.tapView.indicatorColor = self.simulatedTapColor;
    [self.tapView simulateMultiTouchAtPoints:points holdDuration:2.0]; // Simulate a touch
    self.tapView.indicatorColor = self.userTapColor;
}

- (void)loadView {
    self.userTapColor = [UIColor colorWithRed:33/255.0 green:150/255.0 blue:243/255.0 alpha:1.0];
    self.simulatedTapColor = [UIColor colorWithRed:244/255.0 green:67/255.0 blue:54/255.0 alpha:1.0];
    
    self.view = [[TapView alloc] init];
}

#pragma mark - Private

- (TapView*)tapView {
    return (TapView*)self.view;
}

@end
