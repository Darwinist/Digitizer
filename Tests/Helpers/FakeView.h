//
//  FakeView.h
//  Digitizer
//
//  Created by Jonathan Cardasis (C) on 8/5/19.
//  Copyright © 2019 Jonathan Cardasis (C). All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FakeView: UIView

@property (nonatomic, strong) NSSet<UITouch*>* beginTouches;
@property (nonatomic, strong) NSSet<UITouch*>* movedTouches;
@property (nonatomic, strong) NSSet<UITouch*>* endedTouches;

@end

NS_ASSUME_NONNULL_END
