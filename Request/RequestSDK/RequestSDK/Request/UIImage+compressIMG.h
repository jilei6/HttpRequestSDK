//
//  UIImage+compressIMG.h
//  DRRequestSDK
//
//  Created by jilei on 2017/6/6.
//  Copyright © 2017年 jilei. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (compressIMG)

/**
 *  图片的压缩方法
 *
 *  @param sourceImg   要被压缩的图片
 *  @param defineWidth 要被压缩的尺寸(宽)
 *
 *  @return 被压缩的图片
 */
+(UIImage *)IMGCompressed:(UIImage *)sourceImg targetWidth:(CGFloat)defineWidth;

@end

