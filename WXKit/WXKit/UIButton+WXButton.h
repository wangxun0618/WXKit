//
//  UIButton+WXButton.h
//  WXKit
//
//  Created by xun on 2017/11/9.
//  Copyright © 2017年 WXKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (WXButton)

@property (copy, nonatomic) void(^clickBlock)(UIButton *sender);

/**
 添加按钮点击事件

 @param block 回调
 */
- (void)addClickTargetBlock:(void(^)(UIButton *sender))block;

/**
 倒计时

 @param interval 倒计时时间
 @param progressBlock 倒计时过程回调
 @param successBlock 倒计时结束回调
 */
- (void)countdownTimerWithInterval:(NSInteger)interval
                     progressBlock:(void(^)(UIButton *sender, NSInteger time))progressBlock
                      successBlock:(void(^)(UIButton *sender))successBlock;

/**
 上图下文
 
 @param spacing 间距
 */
- (void)verticalImageAndTitle:(CGFloat)spacing;


@end
