//
//  DrawBugColorSeletor.h
//  ShakePostBug
//
//  Created by HuangYiFeng on 7/28/15.
//  Copyright (c) 2015 aimob. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DrawBugColorSeletorDelegate <NSObject>

- (void)selectColor:(UIColor *)selectedColor;

@end

//=========================================

@interface DrawBugColorSeletor : UIView

@property(nonatomic, strong)NSArray *colorList;

@property(nonatomic, assign)id<DrawBugColorSeletorDelegate> delegate;

- (instancetype)initWithColorList:(NSArray *)colorList;

@end
