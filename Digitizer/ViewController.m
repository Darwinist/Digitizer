//
//  ViewController.m
//  Digitizer
//
//  Created by Jonathan Cardasis (C) on 8/1/19.
//  Copyright © 2019 Jonathan Cardasis (C). All rights reserved.
//

#import "ViewController.h"
#import "UIView+Digitizer.h"


@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedView:)];
    [self.view addGestureRecognizer:tapGesture];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    CGPoint touchPoint = CGPointMake(100, 200);
    [self.view simulateTouchAtPoint:touchPoint];
}

- (void)tappedView:(UITapGestureRecognizer*)gesture {
    CGPoint location = [gesture locationInView:self.view];
    
    CGSize size = CGSizeMake(10, 10);
    
    UIView *newView = [[UIView alloc] initWithFrame:CGRectMake(location.x - size.width / 2.0, location.y - size.height / 2.0, size.width, size.height)];
    newView.layer.cornerRadius = size.width / 2.0;
    newView.layer.masksToBounds = true;
    newView.backgroundColor = UIColor.redColor;
    
    [self.view addSubview:newView];
}







@end
