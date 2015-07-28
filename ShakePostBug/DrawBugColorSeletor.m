//
//  DrawBugColorSeletor.m
//  ShakePostBug
//
//  Created by HuangYiFeng on 7/28/15.
//  Copyright (c) 2015 aimob. All rights reserved.
//

#import "DrawBugColorSeletor.h"

CGFloat const SHAKE_POST_COLOR_BUTTON_SIZE = 30;

@interface DrawBugColorSeletor ()

@property(nonatomic, strong)NSArray *btnList;

- (void)initViewComponent;
- (void)colorButtonHandler:(id)sender;

@end


@implementation DrawBugColorSeletor

#pragma mark - init

- (instancetype)initWithColorList:(NSArray *)colorList
{
    if (self = [super init])
    {
        self.colorList = colorList;
    }
    return self;
}

- (void)initViewComponent
{
    NSMutableArray *btns = [NSMutableArray array];
    
    [self.colorList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, SHAKE_POST_COLOR_BUTTON_SIZE, SHAKE_POST_COLOR_BUTTON_SIZE)];
        btn.layer.cornerRadius = SHAKE_POST_COLOR_BUTTON_SIZE / 2;
        btn.tag = idx;
        btn.backgroundColor = (UIColor *)obj;
        [btn addTarget:self action:@selector(colorButtonHandler:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [btns addObject:btn];
    }];
    _btnList = btns;
}

#pragma mark - override

- (void)layoutSubviews
{
    NSInteger btnCount = [_btnList count];
    CGFloat btnGap = (CGRectGetWidth(self.bounds) - btnCount * SHAKE_POST_COLOR_BUTTON_SIZE) / (btnCount + 1);
    btnGap = MAX(2, btnGap);
    
    CGFloat y = (CGRectGetHeight(self.bounds) - SHAKE_POST_COLOR_BUTTON_SIZE) / 2;
    [_btnList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIButton *button = (UIButton *)obj;
        CGRect btnFrame = button.frame;
        btnFrame.origin.x = btnGap + (SHAKE_POST_COLOR_BUTTON_SIZE + btnGap) * idx;
        btnFrame.origin.y = y;
        button.frame = btnFrame;
    }];
}

#pragma mark - Action

- (void)colorButtonHandler:(id)sender
{
    if ([_delegate respondsToSelector:@selector(selectColor:)])
    {
        NSInteger idx = [(UIButton *)sender tag];
        UIColor *selectedColor = [_colorList objectAtIndex:idx];
        [_delegate selectColor:selectedColor];
    }
    
}

#pragma mark - getter & setter

- (void)setColorList:(NSArray *)colorList
{
    if (_colorList == colorList)
    {
        return;
    }
    _colorList = colorList;
    [self initViewComponent];
}

@end
