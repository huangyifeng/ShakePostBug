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
@property(nonatomic, strong)IBOutlet UIImageView *imageView;
@property(nonatomic, strong)UIColor *paintColor;

- (void)initViewComponent;
- (CGContextRef)getPaintContext;

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
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    UIGraphicsEndImageContext();
}

@end
