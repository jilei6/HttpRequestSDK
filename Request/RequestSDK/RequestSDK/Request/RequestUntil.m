//
//  RequestUntil.m
//  RequestSDK
//
//  Created by admin on 2017/8/25.
//  Copyright © 2017年 jilei. All rights reserved.
//

#import "RequestUntil.h"
#import "RequestiToast.h"
@implementation RequestUntil
+ (void)showMessage:(NSString *)msg Type:(int)type
{
    if (msg.length > 0) {
        if (type == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                                            message:msg
                                                           delegate:nil
                                                  cancelButtonTitle:@"确定"
                                                  otherButtonTitles:nil];
            [alert show];
            
        } else if (type == 1)
        {
            RequestiToast *toast = [RequestiToast makeToast:msg];
            [toast setToastPosition:RequestkToastPositionBottom];
            [toast setToastDuration:RequestkToastDurationNormal];
            [toast show];
            
        }
        else if (type == 2) {
            
            RequestiToast *toast = [RequestiToast makeToast:msg];
            [toast setToastPosition:RequestkToastPositionCenter];
            [toast setToastDuration:RequestkToastDurationShort];
            [toast show];
            
        }
    }
}

@end
