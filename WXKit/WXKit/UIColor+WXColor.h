//
//  UIColor+WXColor.h
//  WXKit
//
//  Created by xun on 2017/10/18.
//  Copyright © 2017年 WXKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (WXColor)

/**
 * 使用16进制数字创建颜色
 */
+ (instancetype)wx_colorWithHex:(uint32_t)hex;

/**
 * 随机颜色
 */
+ (instancetype)wx_randomColor;

/**
 * RGB颜色
 */
+ (instancetype)wx_colorWithRed:(uint8_t)red
                          green:(uint8_t)green
                           blue:(uint8_t)blue;

/**
 十六进制字符串显示颜色
 
 @param color 十六进制字符串
 @param alpha 透明度
 @return 颜色
 */
+ (UIColor *)wx_colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;


/**
 *  @brief  渐变颜色
 *
 *  @param fromColor  开始颜色
 *  @param toColor    结束颜色
 *  @param height     渐变高度
 *
 *  @return 渐变颜色
 */
+ (UIColor*)wx_gradientFromColor:(UIColor*)fromColor
                         toColor:(UIColor*)toColor
                      withHeight:(CGFloat)height;

@end
