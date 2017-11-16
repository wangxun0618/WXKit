//
//  UIAlertController+WXAlert.h
//  WXKit
//
//  Created by xun on 2017/10/18.
//  Copyright © 2017年 WXKit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^alertActionBlock)(NSString *title);


typedef NS_ENUM(NSInteger, OptionStyle) {
    OptionStyleStyleOK_Cancel = 0,
    OptionStyleStyleOnlyOK
};

@interface UIAlertController (WXAlert)

/**
 弹出框title Label
 */
@property (nonatomic, strong) UILabel *wxTitleLabel;

/**
 弹出框message Label
 */
@property (nonatomic, strong) UILabel *wxMessageLabel;

/**
 中间弹窗
 
 @param title 标题
 @param message 消息
 @param viewController 弹出提示框VC
 @param sureTitle 右边选项的文字
 @param cancelTitle 左边选项的文字
 @param sureBlock 右边选择选中后执行的代码
 @param cancelBlock 左边选项选中后执行的代码
 @return UIAlertController
 */
+ (UIAlertController *)wx_alertControllerWithTitle:(NSString *)title
                                           message:(NSString *)message
                             presentViewController:(UIViewController *)viewController
                                         sureTitle:(NSString *)sureTitle
                                       cancelTitle:(NSString *)cancelTitle
                                         sureBlock:(void(^)(UIAlertAction *action))sureBlock
                                       cancelBlock:(void(^)(UIAlertAction *action))cancelBlock;

/**
 输入框弹窗

 @param title 标题
 @param message 消息
 @param textFieldNum 输入框数量
 @param viewController 弹出提示框VC
 @param sureTitle 右边选项文字
 @param cancelTitle 左边选项文字
 @param textFieldsBlock 输入框回调
 @param sureBlock 右边选择选中后执行的代码
 @param cancelBlock 左边选项选中后执行的代码
 @return UIAlertController
 */
+ (UIAlertController *)wx_alertControllerWithTitle:(NSString *)title
                                           message:(NSString *)message
                                      textFieldNum:(NSInteger)textFieldNum
                             presentViewController:(UIViewController *)viewController
                                         sureTitle:(NSString *)sureTitle
                                       cancelTitle:(NSString *)cancelTitle
                                    textFieldBlock:(void(^)(NSArray *array))textFieldsBlock
                                         sureBlock:(void(^)(UIAlertAction *action))sureBlock
                                       cancelBlock:(void(^)(UIAlertAction *action))cancelBlock;

/**
 从下面出现的弹窗

 @param title 标题
 @param message 消息
 @param viewController 弹出提示框VC
 @param titles 选项文字数组
 @param cancelTitle 取消
 @param cancelBlock 取消选项后执行的代码
 @param optionsBlock 选择选项后执行的代码
 @return UIAlertController
 */
+ (UIAlertController *)wx_sheetAlertControllerWithTitle:(NSString *)title
                                                message:(NSString *)message
                                  presentViewController:(UIViewController *)viewController
                                             titleArray:(NSArray *)titles
                                            cancelTitle:(NSString *)cancelTitle
                                            cancelBlock:(dispatch_block_t)cancelBlock
                                           optionsBlock:(alertActionBlock)optionsBlock;

@end
