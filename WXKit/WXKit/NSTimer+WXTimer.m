//
//  NSTimer+WXTimer.m
//  WXKit
//
//  Created by xun on 2017/11/9.
//  Copyright © 2017年 WXKit. All rights reserved.
//

#import "NSTimer+WXTimer.h"

@implementation NSTimer (WXTimer)

+ (NSTimer *)wx_scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                         block:(void(^)(void))block
                                       repeats:(BOOL)repeat {
    
    return [self scheduledTimerWithTimeInterval:interval target:self selector:@selector(support_blockInvoke:) userInfo:[block copy] repeats:YES];
}

+ (void)support_blockInvoke:(NSTimer *)timer {
    void(^block)(void) = timer.userInfo;
    if (block) {
        block();
    }
}


@end
