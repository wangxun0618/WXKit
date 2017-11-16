//
//  UIButton+WXButton.m
//  WXKit
//
//  Created by xun on 2017/11/9.
//  Copyright © 2017年 WXKit. All rights reserved.
//

#import "UIButton+WXButton.h"
#import <objc/runtime.h>

@implementation UIButton (WXButton)

#pragma mark --添加block点击事件
- (void)addClickTargetBlock:(void(^)(UIButton *sender))block
{
    self.clickBlock = block;
    [self addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)onClick:(UIButton *)sender {
    if (self.clickBlock) {
        self.clickBlock(sender);
    }
}

- (void)setClickBlock:(void (^)(UIButton *))clickBlock
{
    objc_setAssociatedObject(self, @selector(clickBlock), clickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void(^)(UIButton *))clickBlock
{
    return objc_getAssociatedObject(self,@selector(clickBlock));
}

#pragma mark --倒计时
- (void)countdownTimerWithInterval:(NSInteger)interval
                     progressBlock:(void(^)(UIButton *sender, NSInteger time))progressBlock
                      successBlock:(void(^)(UIButton *sender))successBlock
{
    __block NSInteger timeOut = interval;
    dispatch_queue_t queue = dispatch_queue_create("countdown.button", DISPATCH_QUEUE_SERIAL);
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, dispatch_walltime(NULL, 0), 1*NSEC_PER_SEC, 0);//每秒执行
    dispatch_source_set_event_handler(timer, ^{
        
        if (timeOut == 0) { //倒计时结束
            dispatch_source_cancel(timer);
            if (progressBlock) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    successBlock(self);
                });
            }
        } else {
            if (progressBlock) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    progressBlock(self,timeOut--);
                });
            }
        }
    });
    
    dispatch_resume(timer);
}

#pragma mark --上图下文
- (void)verticalImageAndTitle:(CGFloat)spacing
{
    self.titleEdgeInsets = UIEdgeInsetsMake(0, -self.imageView.intrinsicContentSize.width, -self.imageView.intrinsicContentSize.height-spacing/2, 0);
    
    self.imageEdgeInsets = UIEdgeInsetsMake(-self.titleLabel.intrinsicContentSize.height-spacing/2, 0, 0, -self.titleLabel.intrinsicContentSize.width);
    
}


@end
