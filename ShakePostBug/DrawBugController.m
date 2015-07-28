//
//  DrawBugController.m
//  ShakePostBug
//
//  Created by HuangYiFeng on 7/24/15.
//  Copyright (c) 2015 aimob. All rights reserved.
//

#import "DrawBugController.h"
#import "DrawBugColorSeletor.h"

CGFloat const SHAKE_POST_TEXT_VIEW_HEIGHT = 180;
CGFloat const SHAKE_POST_TEXT_VIEW_PADDING = 10;
CGFloat const SHAKE_POST_COLOR_SELECTOR_HEIGHT = 50;;
CGFloat const SHAKE_POST_COLOR_SELECTOR_PADDING = 10;;

@interface DrawBugController ()

//@property(nonatomic, strong)
@property(nonatomic, weak)IBOutlet UIButton *colorButton;
@property(nonatomic, weak)IBOutlet UIImageView *imageView;
@property(nonatomic, weak)IBOutlet UIView *topToolbar;
@property(nonatomic, weak)IBOutlet UIView *bottomToolbar;
@property(nonatomic, weak)IBOutlet NSLayoutConstraint *bottomToolbarBottomConstraint;
@property(nonatomic, strong)UITextView *textView;
@property(nonatomic, strong)DrawBugColorSeletor *colorSelector;

@property(nonatomic, assign)BOOL        isTexting;
@property(nonatomic, strong)NSArray     *colors;
@property(nonatomic, assign)NSInteger   selectedColorIndex;
@property(nonatomic, strong)NSString    *bugText;

- (void)initViewComponent;
- (CGContextRef)getPaintContext;
- (void)showToolbar:(BOOL)isShow;
- (void)showBottomToolbar:(BOOL)isShow completion:(void(^)(BOOL finished))completion;
- (void)showTextView;
- (void)hideTextView;

- (void)showColorSelector;
- (void)hideColorSelector;

- (void)refreshColorButtonTint;


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
    
    _isTexting = NO;
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
    [self hideColorSelector];
    
    [UIView animateWithDuration:0.3 animations:^{
        [self.view layoutIfNeeded];
    } completion:^(BOOL finished) {
        if (completion)
        {
            completion(finished);
        }
    }];
}

- (void)refreshColorButtonTint
{
    self.colorButton.tintColor = [_colors objectAtIndex:_selectedColorIndex];
}

- (void)showTextView
{
    CGRect outterFrame = self.view.frame;
    
    CGRect frame = CGRectMake(SHAKE_POST_TEXT_VIEW_PADDING, -SHAKE_POST_TEXT_VIEW_HEIGHT , CGRectGetWidth(outterFrame) - 2 * SHAKE_POST_TEXT_VIEW_PADDING, SHAKE_POST_TEXT_VIEW_HEIGHT);
    self.textView.frame = frame;
    
    [self.view insertSubview:self.textView aboveSubview:_imageView];
    [self.textView becomeFirstResponder];
    
    frame.origin.y = CGRectGetHeight(_topToolbar.bounds) + SHAKE_POST_TEXT_VIEW_PADDING;
    
    [UIView animateWithDuration:0.4 animations:^{
        self.textView.frame = frame;
    } completion:^(BOOL finished) {
        _isTexting = YES;
    }];
}

- (void)hideTextView
{
    CGRect outterFrame = self.view.frame;
    CGRect frame = CGRectMake(SHAKE_POST_TEXT_VIEW_PADDING, -SHAKE_POST_TEXT_VIEW_HEIGHT , CGRectGetWidth(outterFrame) - 2 * SHAKE_POST_TEXT_VIEW_PADDING, SHAKE_POST_TEXT_VIEW_HEIGHT);

    [self.textView resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        self.textView.frame = frame;
    } completion:^(BOOL finished) {
        [self.textView removeFromSuperview];
        _isTexting = NO;
        [self showBottomToolbar:YES completion:nil];
    }];
}

- (void)showColorSelector
{
    self.colorSelector.alpha = 0;
    [self.view addSubview:self.colorSelector];
    
    CGFloat y = CGRectGetMinY(_bottomToolbar.frame) - SHAKE_POST_COLOR_SELECTOR_PADDING - SHAKE_POST_COLOR_SELECTOR_HEIGHT;
    CGFloat width = CGRectGetWidth(self.view.frame) - 2 * SHAKE_POST_COLOR_SELECTOR_PADDING;
    self.colorSelector.frame = CGRectMake(SHAKE_POST_COLOR_SELECTOR_PADDING, y, width, SHAKE_POST_COLOR_SELECTOR_HEIGHT);
    
    [UIView animateWithDuration:0.3 animations:^{
        self.colorSelector.alpha = 1.0;
    }];
}

- (void)hideColorSelector
{
    [UIView animateWithDuration:0.3 animations:^{
        self.colorSelector.alpha = 0;
    } completion:^(BOOL finished) {
        [self.colorSelector removeFromSuperview];
    }];
}


#pragma mark - Responder

- (BOOL)canBecomeFirstResponder
{
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!_isTexting)
    {
        UIGraphicsBeginImageContext(_imageView.bounds.size);
        
        UITouch *touch = [touches anyObject];
        CGPoint currentPoint = [touch locationInView:_imageView];
        CGContextRef context = [self getPaintContext];
        [_imageView.layer renderInContext:context];
        
        CGContextMoveToPoint(context, currentPoint.x, currentPoint.y);
        
        [self showToolbar:NO];
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (!_isTexting)
    {
        [self hideColorSelector];
        
        CGContextRef context = [self getPaintContext];
        UITouch *touch = [touches anyObject];
        CGPoint currentPoint = [touch locationInView:_imageView];
        
        CGContextAddLineToPoint(context, currentPoint.x, currentPoint.y);
        CGContextStrokePath(context);
        
        CGContextMoveToPoint(context, currentPoint.x, currentPoint.y);
        
        _imageView.image = UIGraphicsGetImageFromCurrentImageContext();
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_isTexting)
    {
        [self hideTextView];
    }
    else
    {
        UIGraphicsEndImageContext();
        [self showToolbar:YES];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (_isTexting)
    {
        [self hideTextView];
    }
    else
    {
        UIGraphicsEndImageContext();
        [self showToolbar:YES];
    }
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
    [self showColorSelector];
}

- (IBAction)textBtnHandler:(id)sender
{
    [self showBottomToolbar:NO completion:^(BOOL finished) {
        [self showTextView];
    }];
}

- (IBAction)clearBtnHandler:(id)sender
{
    _imageView.image = _image;
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

- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc] init];
        _textView.layer.cornerRadius = 10;
        _textView.layer.borderWidth = 1;
        _textView.layer.borderColor = [UIColor grayColor].CGColor;
        _textView.textContainerInset = UIEdgeInsetsMake(10, 10, 10, 10);
    }
    return _textView;
}

- (DrawBugColorSeletor *)colorSelector
{
    if (!_colorSelector)
    {
        _colorSelector = [[DrawBugColorSeletor alloc] initWithColorList:_colors];
        _colorSelector.layer.cornerRadius = 5;
        _colorSelector.backgroundColor = [UIColor darkGrayColor];
        _colorSelector.delegate = self;
    }
    return _colorSelector;
}

#pragma mark - DrawBugColorSeletorDelegate

- (void)selectColor:(UIColor *)selectedColor
{
    _selectedColorIndex = [_colors indexOfObject:selectedColor];
    [self refreshColorButtonTint];
}

#pragma mark - status bar

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

@end
