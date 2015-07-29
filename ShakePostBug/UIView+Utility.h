//
//  UIView+Utility.h
//  Gemini
//
//  Created by kojima on 10/12/08.
//  Copyright 2010 Cybozu, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Utility)

- (UIImage *)captureScreenShot;
- (UIImage *)captureScreenShot:(BOOL)fullContents;
- (UIImage *)captureScreenShotPNGType;
- (UIImage *)captureScreenShotPNGType:(BOOL)fullContents;
- (BOOL)hasFirstResponder;
- (UIView *)findFirstResponder;

+ (id)viewWithNibName:(NSString *)nibName;

@end
