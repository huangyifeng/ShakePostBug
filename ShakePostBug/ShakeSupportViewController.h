//
//  ShakeSupportViewController.h
//  ShakePostBug
//
//  Created by huang yifeng on 15/7/30.
//  Copyright (c) 2015年 aimob. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShakeSupportViewController : UIViewController

@property(nonatomic, assign)BOOL isShakingEnabled;
@property(nonatomic, assign)NSTimeInterval shakeDuration;
@property(nonatomic, strong)void(^actionHandler)(void);

@end
