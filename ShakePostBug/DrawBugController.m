//
//  DrawBugController.m
//  ShakePostBug
//
//  Created by HuangYiFeng on 7/24/15.
//  Copyright (c) 2015 aimob. All rights reserved.
//

#import "DrawBugController.h"

@interface DrawBugController ()

//@property(nonatomic, assign)CGPoint lastPoint;
@property(nonatomic, weak)IBOutlet UIImageView *imageView;
@property(nonatomic, weak)IBOutlet UIView *topToolbar;
@property(nonatomic, weak)IBOutlet UIView *bottomToolbar;

@property(nonatomic, strong)UIColor *paintColor;

- (void)initViewComponent;
- (CGContextRef)getPaintContext;
- (void)showToolbar:(BOOL)isShow;

- (IBAction)close:(id)sender;
- (IBAction)doPost:(id)sender;

@end

@implementation DrawBugController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initViewComponent];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - private

- (void)initViewComponent
{
    _imageView.image = _image;
    _paintColor = [UIColor redColor];
//    _lastPoint = CGPointZero;
}

- (CGContextRef)getPaintContext
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, _paintColor.CGColor);
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    
    return context;
}

-(void)showToolbar:(BOOL)isShow
{
    CGFloat alpha = isShow? 1 : 0;
    
    [UIView animateWithDuration:0.3 animations:^{
        _topToolbar.alpha = alpha;
        _bottomToolbar.alpha = alpha;
    }];
}

#pragma mark - getter & setter

- (void)setImage:(UIImage *)image
{
    if (_image == image)
    {
        return;
    }
    _image = image;
    _imageView.image = image;
}

#pragma mark - Responder

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIGraphicsBeginImageContext(_imageView.bounds.size);
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:_imageView];
    CGContextRef context = [self getPaintContext];
    [_imageView.layer renderInContext:context];
    
    CGContextMoveToPoint(context, currentPoint.x, currentPoint.y);
    
    [self showToolbar:NO];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGContextRef context = [self getPaintContext];
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:_imageView];
//    NSLog(@"touchesMoved, %@",NSStringFromCGPoint(currentPoint));
    
    CGContextAddLineToPoint(context, currentPoint.x, currentPoint.y);
    CGContextStrokePath(context);
    
    CGContextMoveToPoint(context, currentPoint.x, currentPoint.y);
    
    _imageView.image = UIGraphicsGetImageFromCurrentImageContext();
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIGraphicsEndImageContext();
    [self showToolbar:YES];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIGraphicsEndImageContext();
    [self showToolbar:YES];
}

#pragma mark - Action

- (void)close:(id)sender
{
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)doPost:(id)sender
{
    
}


@end
