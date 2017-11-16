//
//  WXQRCodeGenerateManager.h
//  WXKit
//
//  Created by xun on 2017/11/15.
//  Copyright © 2017年 WXKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface WXQRCodeGenerateManager : NSObject

/** 生成一张普通的二维码 */
+ (UIImage *)wx_generateWithDefaultQRCodeData:(NSString *)data
                            imageViewWidth:(CGFloat)imageViewWidth;

/** 生成一张带有logo的二维码（logoScaleToSuperView：相对于父视图的缩放比取值范围0-1；0，不显示，1，代表与父视图大小相同）*/
+ (UIImage *)wx_generateWithLogoQRCodeData:(NSString *)data
                          logoImageName:(NSString *)logoImageName
                   logoScaleToSuperView:(CGFloat)logoScaleToSuperView;

/** 生成一张彩色的二维码 */
+ (UIImage *)wx_generateWithColorQRCodeData:(NSString *)data
                         backgroundColor:(CIColor *)backgroundColor
                               mainColor:(CIColor *)mainColor;


@end
