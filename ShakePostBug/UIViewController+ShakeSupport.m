//
//  UIViewController+ShakeSupport.m
//  ShakePostBug
//
//  Created by huang yifeng on 15/7/3.
//  Copyright (c) 2015年 aimob. All rights reserved.
//

#import "UIViewController+ShakeSupport.h"
#import <objc/runtime.h>
#import "DrawBugController.h"

@implementation UIViewController (ShakeSupport)

#pragma mark - responder

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

#pragma mark - public 



#pragma mark - motion event

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake && self.isShakingEnabled)
    {
        NSLog(@"shake began");
        self.shakingTimer = [NSTimer scheduledTimerWithTimeInterval:self.shakeDuration target:self selector:@selector(shakeTimerHandler:) userInfo:nil repeats:NO];
    }
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake && self.isShakingEnabled)
    {
        [self.shakingTimer invalidate];
        NSLog(@"shake ended");
    }
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake && self.isShakingEnabled)
    {
        [self.shakingTimer invalidate];
        NSLog(@"shake cancelled");
    }
}

#pragma mark - Action

- (void)shakeTimerHandler:(NSTimer *)timer
{
    
}

#pragma mark - getter & setter

- (BOOL)isShakingEnabled
{
    id value = objc_getAssociatedObject(self, @"isShakingEnabled");
    return [value boolValue];
}

- (void)setIsShakingEnabled:(BOOL)isShakingEnabled;
{
    objc_setAssociatedObject(self, @"isShakingEnabled", [NSNumber numberWithBool:isShakingEnabled], OBJC_ASSOCIATION_ASSIGN);
}

- (NSTimeInterval)shakeDuration
{
    id value = objc_getAssociatedObject(self, @"shakeDuration");
    return value ? [value doubleValue] : 1;
}

- (void)setShakeDuration:(NSTimeInterval)shakeDuration
{
    objc_setAssociatedObject(self, @"shakeDuration", [NSNumber numberWithDouble:shakeDuration], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSTimer *)shakingTimer
{
    return objc_getAssociatedObject(self, @"shakingTimer");
}

- (void)setShakingTimer:(NSTimer *)shakingTimer
{
    return objc_setAssociatedObject(self, @"shakingTimer", shakingTimer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
