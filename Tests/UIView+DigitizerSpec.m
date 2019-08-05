//
//  UIView+DigitizerSpec.m
//  DigitizerTests
//
//  Created by Jonathan Cardasis (C) on 8/5/19.
//  Copyright © 2019 Jonathan Cardasis (C). All rights reserved.
//

#import <XCTest/XCTest.h>
#import <Digitizer/Digitizer.h>
#import "FakeView.h"
#import "UIControl+Testing.h"

@interface UIView_DigitizerSpec : XCTestCase
@property (nonatomic) FakeView *view;
@end

@implementation UIView_DigitizerSpec

- (void)setUp {
    [super setUp];
    self.view = [[FakeView alloc] initWithFrame:CGRectMake(0, 0, 40, 40)];
    
    // Add view to a fake window to accept UIApplication events (touches & gestures)
    UIWindow *specWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 800, 800)];
    [specWindow makeKeyAndVisible];
    [specWindow addSubview:self.view];
}

- (void)testViewReceivesBeginAndEndTouchEventsForTouch {
    // When
    [self.view simulateTouchAtPoint:self.view.center];
    
    // Then
    XCTAssertEqual(self.view.beginTouches.count, 1);
    XCTAssertEqual(self.view.endedTouches.count, 1);
}

- (void)testViewReceivesBeginAndEndTouchEventsForMultiTouch {
    // Given
    NSArray *points = @[[NSValue valueWithCGPoint:CGPointMake(0, 0)], [NSValue valueWithCGPoint:CGPointMake(20, 20)]];
    
    // When
    [self.view simulateMultiTouchAtPoints:points];
    
    // Then
    XCTAssertEqual(self.view.beginTouches.count, 2);
    XCTAssertEqual(self.view.endedTouches.count, 2);
}

- (void)testViewRecievesDelayedEndTouchEventForLongPress {
    // Given
    NSTimeInterval duration = 0.1;
    
    // When
    [self.view simulateLongTouchAtPoint:self.view.center holdDuration:duration];
    
    // Then
    XCTAssertEqual(self.view.beginTouches.count, 1);
    XCTAssertEqual(self.view.endedTouches.count, 0);
    XCTestExpectation *expectation = [[XCTestExpectation alloc] initWithDescription:@"Long press"];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, duration * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
        XCTAssertEqual(self.view.endedTouches.count, 1);
        [expectation fulfill];
    });
    
    [self waitForExpectations:@[expectation] timeout:duration];
}


@end
