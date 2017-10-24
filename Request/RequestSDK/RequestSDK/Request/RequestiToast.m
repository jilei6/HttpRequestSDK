//
//  DRiToast.m
//  DRRequestSDK
//
//  Created by jilei on 2017/6/6.
//  Copyright © 2017年 jilei. All rights reserved.
//

#import "RequestiToast.h"


@implementation RequestiToast
@synthesize toastPosition;
@synthesize toastDuration;
- (id)init
{
    if (self = [super init])
    {
        toastPosition = RequestkToastPositionCenter;
        toastDuration = RequestkToastDurationNormal;
    }
    return self;
}

- (id)initWithText:(NSString *)text
{
    if (self = [super init])
    {
        toastPosition = RequestkToastPositionCenter;
        toastDuration = RequestkToastDurationNormal;
        self.toastText= text;
    }
    return self;
}

+ (RequestiToast *)makeToast:(NSString *)text
{
    RequestiToast *toast = [[RequestiToast alloc]initWithText:text];
    return toast;
}

- (void)show
{
    CGFloat kToastTextPadding     = 10;
    CGFloat kToastButtonPaddding  = 15;
    CGFloat kToastLabelWidth      = [UIScreen mainScreen].bounds.size.width - 15*2 - 10*2;
    CGFloat kToastLabelHeight     = 60;
    CGFloat kToastMargin          = 45;
    CGFloat kToastXOffset         = 95;
    
    UIFont *font   = [UIFont systemFontOfSize:14.0f];
    CGSize textSize= [_toastText sizeWithFont:font constrainedToSize:CGSizeMake(kToastLabelWidth, kToastLabelHeight)];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, textSize.width + 2 * kToastTextPadding,
                                                              textSize.height + 2 * kToastTextPadding)];
    label.backgroundColor = [UIColor clearColor];
    label.textColor = [UIColor whiteColor];
    label.font = font;
    label.text = _toastText;
    label.alpha = 0.0f;
    label.numberOfLines = 0;
    label.shadowColor = [UIColor darkGrayColor];
    label.shadowOffset = CGSizeMake(1, 1);
    label.textAlignment = NSTextAlignmentCenter;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.alpha = 0.0f;
    button.bounds = CGRectMake(0, 0, textSize.width + 2 * kToastButtonPaddding, textSize.height + 2 * kToastButtonPaddding);
    label.center = CGPointMake(button.bounds.size.width / 2, button.bounds.size.height / 2);
    [button addSubview:label];
    
    button.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
    button.layer.cornerRadius = 5;
    
    UIWindow *window = [[[UIApplication sharedApplication] windows] objectAtIndex:0];
    CGPoint point = window.center;
    CGPoint center = window.center;
    CGFloat dx = 0;
    
    if (toastPosition == RequestkToastPositionTop)
    {
        point = CGPointMake(point.x, kToastMargin + button.bounds.size.height);
        dx    = center.x - kToastXOffset;
    }
    else if(toastPosition == RequestkToastPositionBottom)
    {
        point = CGPointMake(point.x, window.bounds.size.height - kToastMargin - button.bounds.size.height);
        dx    = kToastXOffset - center.x ;
        
    }
    button.center = point;
    
    UIInterfaceOrientation currentOrient= [UIApplication
                                           sharedApplication].statusBarOrientation;
    
    if(currentOrient == UIDeviceOrientationLandscapeRight)
    {
        CGAffineTransform rotateTransform   = CGAffineTransformMakeRotation((M_PI/2) * -1);
        CGAffineTransform translateTransform= CGAffineTransformMakeTranslation(-dx,center.y - point.y);
        CGAffineTransform t = CGAffineTransformConcat(rotateTransform,translateTransform);
        button.transform = CGAffineTransformConcat(button.transform, t);
    }
    else if(currentOrient == UIDeviceOrientationLandscapeLeft)
    {
        CGAffineTransform rotateTransform   = CGAffineTransformMakeRotation((M_PI/2));
        CGAffineTransform translateTransform= CGAffineTransformMakeTranslation(dx,center.y - point.y);
        CGAffineTransform t = CGAffineTransformConcat(rotateTransform,translateTransform);
        button.transform = CGAffineTransformConcat(button.transform, t);
    }
    else if(currentOrient == UIDeviceOrientationPortraitUpsideDown)
    {
        button.transform = CGAffineTransformRotate(button.transform, M_PI);
    }
    
    [window addSubview:button];
    view = button;
    
    [UIView animateWithDuration:0.5 animations:^{
        button.alpha = 1.0f;
        label.alpha = 1.0f;
    }];
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:(CGFloat)toastDuration / 1000.0
                                             target:self selector:@selector(onHideToast:)
                                           userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    
    
    [button addTarget:self action:@selector(hideToast:) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void)hideToast:(id)sender
{
    [self doHideToast];
}

- (void)onHideToast:(NSTimer *)timer
{
    [self doHideToast];
}

- (void)doHideToast
{
    [UIView beginAnimations:nil context:nil];
    view.alpha = 0;
    [UIView commitAnimations];
    
    NSTimer *timer = [NSTimer timerWithTimeInterval:500
                                             target:self selector:@selector(onRemoveToast:)
                                           userInfo:nil repeats:NO];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)onRemoveToast:(NSTimer *)timer
{
    if (view) {
        [view removeFromSuperview];
    }
}


@end
