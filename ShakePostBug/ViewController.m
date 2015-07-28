//
//  ViewController.m
//  ShakePostBug
//
//  Created by huang yifeng on 15/7/2.
//  Copyright (c) 2015年 aimob. All rights reserved.
//

#import "ViewController.h"
#import "DrawBugController.h"
#import "UIViewController+ShakeSupport.h"

@interface ViewController ()

- (IBAction)shotHandler:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark - Action

- (void)shotHandler:(id)sender
{
    DrawBugController *drawBug = [[DrawBugController alloc] init];
    
    UIGraphicsBeginImageContext(self.view.bounds.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.view.window.layer renderInContext:context];
    drawBug.image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    [self presentViewController:drawBug animated:NO completion:nil];
}

@end
