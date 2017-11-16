//
//  NSTimer+WXTimer.h
//  WXKit
//
//  Created by xun on 2017/11/9.
//  Copyright © 2017年 WXKit. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (WXTimer)

/**
 Weak Timer

 @param interval 时间间隔
 @param block 回调
 @param repeat 是否重复
 @return NSTimer
 */
+ (NSTimer *)wx_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         block:(void(^)(void))block
                                       repeats:(BOOL)repeat;

@end
