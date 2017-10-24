//
//  DRiToast.h
//  DRRequestSDK
//
//  Created by jilei on 2017/6/6.
//  Copyright © 2017年 jilei. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
typedef enum
{
    RequestkToastPositionTop,
    RequestkToastPositionCenter,
    RequestkToastPositionBottom,
} RequestToastPosition;

typedef enum
{
    RequestkToastDurationShort = 2000,
    RequestkToastDurationNormal= 4000,
    RequestkToastDurationLong  =10000,
} RequestToastDuration;

@interface RequestiToast : NSObject
{
    RequestToastPosition   toastPosition;
    RequestToastDuration   toastDuration;
    NSString        *toastText;
    UIView          *view;
}

@property (assign,nonatomic)    RequestToastPosition toastPosition;
@property (assign,nonatomic)    RequestToastDuration toastDuration;
@property (copy,nonatomic)    NSString      *toastText;


- (id)initWithText: (NSString *)text;
- (void)show;

+ (RequestiToast *)makeToast: (NSString *)text;


- (void)hideToast: (id)sender;
- (void)onHideToast: (NSTimer *)timer;
- (void)onRemoveToast: (NSTimer *)timer;
- (void)doHideToast;

@end
