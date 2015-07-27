//
//  DrawBugController.m
//  ShakePostBug
//
//  Created by HuangYiFeng on 7/24/15.
//  Copyright (c) 2015 aimob. All rights reserved.
//

#import "DrawBugController.h"

@interface DrawBugController ()

//@property(nonatomic, strong)
@property(nonatomic, weak)IBOutlet UIButton *colorButton;
@property(nonatomic, weak)IBOutlet UIImageView *imageView;
@property(nonatomic, weak)IBOutlet UIView *topToolbar;
@property(nonatomic, weak)IBOutlet UIView *bottomToolbar;
@property(nonatomic, weak)IBOutlet NSLayoutConstraint *bottomToolbarBottomConstraint;

@property(nonatomic, assign)BOOL        isTexting;
@property(nonatomic, strong)NSArray     *colors;
@property(nonatomic, assign)NSInteger   selectedColorIndex;
@property(nonatomic, strong)NSString    *bugText;

- (void)initViewComponent;
- (CGContextRef)getPaintContext;
- (void)showToolbar:(BOOL)isShow;
- (void)showBottomToolbar:(BOOL)isShow completion:(void(^)(BOOL finished))completion;

- (IBAction)close:(id)sender;
- (IBAction)doPost:(id)sender;
- (IBAction)colorBtnHandler:(id)sender;
- (IBAction)textBtnHandler:(id)sender;
- (IBAction)clearBtnHandler:(id)sender;

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
    _selectedColorIndex = 0;
    _colors = [NSArray arrayWithObjects:[UIColor redColor],
               [UIColor blueColor],
               [UIColor yellowColor],
               [UIColor orangeColor],
               [UIColor greenColor],
               [UIColor whiteColor], nil];
    
    [self refreshColorButtonTint];
//    _lastPoint = CGPointZero;
}

- (CGContextRef)getPaintContext
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(context, 2);
    CGContextSetStrokeColorWithColor(context, [(UIColor *)[_colors objectAtIndex:_selectedColorIndex] CGColor]);
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

- (void)showBottomToolbar:(BOOL)isShow completion:(void(^)(BOOL finished))completion
{
    CGFloat distance = isShow ? 0 : -_bottomToolbar.bounds.size.height;
    _bottomToolbarBottomConstraint.constant = distance;
    
    [UIView animateWithDuration:1 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        completion(finished);
    }];
}

- (void)refreshColorButtonTint
{
    self.colorButton.tintColor = [_colors objectAtIndex:_selectedColorIndex];
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

- (IBAction)colorBtnHandler:(id)sender
{
    
}

- (IBAction)textBtnHandler:(id)sender
{
    [self showBottomToolbar:NO completion:^(BOOL finished) {
        
    }];
}

- (IBAction)clearBtnHandler:(id)sender
{
    _imageView.image = _image;
}

#pragma mark - status bar

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
