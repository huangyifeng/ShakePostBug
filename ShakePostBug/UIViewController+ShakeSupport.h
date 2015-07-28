//
//  UIViewController+ShakeSupport.h
//  ShakePostBug
//
//  Created by huang yifeng on 15/7/3.
//  Copyright (c) 2015年 aimob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (ShakeSupport)

//public
@property(nonatomic, assign)BOOL isShakingEnabled;
@property(nonatomic, assign)NSTimeInterval shakeDuration;
@property(nonatomic, strong)void(^actionHandler)(void);

//private
@property(nonatomic, strong)NSTimer *shakingTimer;
- (void)shakeTimerHandler:(NSTimer *)timer;


@end
