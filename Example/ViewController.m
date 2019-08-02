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

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CGPoint touchPoint = CGPointMake(100, 200);
    [self.view simulateTouchAtPoint:touchPoint];
}


- (void)loadView {
    self.view = [[TapView alloc] init];
}

- (void)tappedView:(UITapGestureRecognizer*)gesture { // TODO: remove
    CGPoint location = [gesture locationInView:self.view];
    
    CGSize size = CGSizeMake(10, 10);
    
    UIView *newView = [[UIView alloc] initWithFrame:CGRectMake(location.x - size.width / 2.0, location.y - size.height / 2.0, size.width, size.height)];
    newView.layer.cornerRadius = size.width / 2.0;
    newView.layer.masksToBounds = true;
    newView.backgroundColor = UIColor.redColor;
    
    [self.view addSubview:newView];
}



@end
