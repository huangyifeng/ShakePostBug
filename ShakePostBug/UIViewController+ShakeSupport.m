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

#pragma mark - motion event

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake && self.isShakingEnabled)
    {
        NSLog(@"shake began -- %@",[[NSRunLoop currentRunLoop] currentMode]);
        self.shakingTimer = [NSTimer scheduledTimerWithTimeInterval:self.shakeDuration target:self selector:@selector(shakeTimerHandler:) userInfo:nil repeats:NO];
    }
    else
    {
        [self.nextResponder motionBegan:motion withEvent:event];
    }
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake && self.isShakingEnabled)
    {
        [self.shakingTimer invalidate];
        NSLog(@"shake ended");
    }
    else
    {
        [self.nextResponder motionEnded:motion withEvent:event];
    }
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event
{
    if (motion == UIEventSubtypeMotionShake && self.isShakingEnabled)
    {
//        [self.shakingTimer invalidate];
        NSLog(@"shake cancelled");
    }
    else
    {
        [self.nextResponder motionCancelled:motion withEvent:event];
    }
}

#pragma mark - Action

- (void)shakeTimerHandler:(NSTimer *)timer
{
    if (self.actionHandler)
    {
        self.actionHandler();
    }
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

- (void (^)(void))actionHandler
{
    return objc_getAssociatedObject(self, @"shakeActionHandler");
}

- (void)setActionHandler:(void (^)(void))actionHandler
{
    objc_setAssociatedObject(self, @"shakeActionHandler", actionHandler, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

@end
