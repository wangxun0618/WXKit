//
//  WXQRCodeScanningView.h
//  WXKit
//
//  Created by xun on 2017/11/15.
//  Copyright © 2017年 WXKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WXQRCodeScanningView : UIView

/** 取景框图片 **/
@property (strong, nonatomic) NSString *captureImageName;

/** 扫描线条图片 **/
@property (strong, nonatomic) NSString *lineImageName;

/** 有效扫描区 **/
@property (strong, nonatomic) UIView *contentView;


/**
 初始化

 @param frame view frame
 @param contentFrame 扫描区域 frame
 @param captureImage 扫描区域图片
 @param lineImage 扫描线条
 @return WXQRCodeScanningView
 */
- (instancetype)initWithFrame:(CGRect)frame
                 contentFrame:(CGRect)contentFrame
                 captureImage:(NSString *)captureImage
                    lineImage:(NSString *)lineImage;

/**
 开启动画

 @param duration 每次动画执行时间
 */
- (void)wx_startAnimationWithDuration:(NSTimeInterval)duration;

/** 停止动画 **/
- (void)wx_stopAnimation;


@end
