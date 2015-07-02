//
//  UIViewController+ShakeSupport.m
//  ShakePostBug
//
//  Created by huang yifeng on 15/7/3.
//  Copyright (c) 2015年 aimob. All rights reserved.
//

#import "UIViewController+ShakeSupport.h"

@implementation UIViewController (ShakeSupport)

#pragma mark - responder

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

#pragma mark - motion event

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        NSLog(@"shake began");
    }
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        NSLog(@"shake ended");
    }
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake)
    {
        NSLog(@"shake cancelled");
    }
}

@end
