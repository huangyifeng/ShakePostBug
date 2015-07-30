//
//  ShakeSupportViewController.m
//  ShakePostBug
//
//  Created by huang yifeng on 15/7/30.
//  Copyright (c) 2015年 aimob. All rights reserved.
//

#import "ShakeSupportViewController.h"

@interface ShakeSupportViewController ()

//private
@property(nonatomic, strong)NSTimer *shakingTimer;

- (void)shakeTimerHandler:(NSTimer *)timer;

@end

@implementation ShakeSupportViewController

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
        //        [self.shakingTimer invalidate];
        NSLog(@"shake cancelled");
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

@end
