//
//  DrawBugController.h
//  ShakePostBug
//
//  Created by HuangYiFeng on 7/24/15.
//  Copyright (c) 2015 aimob. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawBugColorSeletor.h"

@interface DrawBugController : UIViewController <DrawBugColorSeletorDelegate>

@property(nonatomic, strong)UIImage *image;

@end
