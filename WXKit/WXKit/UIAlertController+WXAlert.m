//
//  UIAlertController+WXAlert.m
//  WXKit
//
//  Created by xun on 2017/10/18.
//  Copyright © 2017年 WXKit. All rights reserved.
//

#import "UIAlertController+WXAlert.h"
#import "NSObject+WXRuntime.h"

@implementation UIAlertController (WXAlert)
@dynamic wxTitleLabel;
@dynamic wxMessageLabel;

#pragma mark --alert
+ (UIAlertController *)wx_alertControllerWithTitle:(NSString *)title
                                           message:(NSString *)message
                             presentViewController:(UIViewController *)viewController
                                           sureTitle:(NSString *)sureTitle
                                       cancelTitle:(NSString *)cancelTitle
                                           sureBlock:(void(^)(UIAlertAction *action))sureBlock
                                       cancelBlock:(void(^)(UIAlertAction *action))cancelBlock{
    
    UIAlertController *alert = [self wx_alertControllerWithTitle:title message:message sureTitle:sureTitle cancelTitle:cancelTitle sureBlock:sureBlock cancelBlock:cancelBlock];
    [viewController presentViewController:alert animated:YES completion:nil];
    return alert;
}


#pragma mark --textField alert
+ (UIAlertController *)wx_alertControllerWithTitle:(NSString *)title
                                           message:(NSString *)message
                                      textFieldNum:(NSInteger)textFieldNum
                             presentViewController:(UIViewController *)viewController
                                         sureTitle:(NSString *)sureTitle
                                       cancelTitle:(NSString *)cancelTitle
                                    textFieldBlock:(void(^)(NSArray *array))textFieldsBlock
                                         sureBlock:(void(^)(UIAlertAction *action))sureBlock
                                       cancelBlock:(void(^)(UIAlertAction *action))cancelBlock
{
    UIAlertController *alert=[self wx_alertControllerWithTitle:title message:message sureTitle:sureTitle cancelTitle:cancelTitle sureBlock:sureBlock cancelBlock:cancelBlock];
    
    for (int i=0; i<textFieldNum; i++) {
        [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        }];
    }
    textFieldsBlock(alert.textFields);
    [viewController presentViewController:alert animated:YES completion:nil];
    return alert;
}

+ (UIAlertController *)wx_alertControllerWithTitle:(NSString *)title
                                           message:(NSString *)message
                                         sureTitle:(NSString *)sureTitle
                                       cancelTitle:(NSString *)cancelTitle
                                         sureBlock:(void(^)(UIAlertAction *action))sureBlock
                                       cancelBlock:(void(^)(UIAlertAction *action))cancelBlock
{
    UIAlertController* alert=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    if (sureTitle) {
        UIAlertAction *sure=[UIAlertAction actionWithTitle:sureTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (sureBlock) {
                sureBlock(action);
            }
        }];
        [alert addAction:sure];
    }
    
    if (cancelTitle) {
        UIAlertAction* cancel=[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancelBlock) {
                cancelBlock(action);
            }
        }];
        [alert addAction:cancel];
    }
    
    return alert;
}


#pragma --sheet alert
+ (UIAlertController *)wx_sheetAlertControllerWithTitle:(NSString *)title
                                                message:(NSString *)message
                                  presentViewController:(UIViewController *)viewController
                                             titleArray:(NSArray *)titles
                                            cancelTitle:(NSString *)cancelTitle
                                            cancelBlock:(dispatch_block_t)cancelBlock
                                           optionsBlock:(alertActionBlock)optionsBlock {
    
    UIAlertController* alert=[UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleActionSheet];
    
    if (cancelTitle) {
        UIAlertAction *action=[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            if (cancelBlock) {
                cancelBlock();
            }
        }];
        [alert addAction:action];
    }
    
    for (int i = 0; i<titles.count; i++) {
        UIAlertAction *action=[UIAlertAction actionWithTitle:titles[i] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            if (optionsBlock) {
                optionsBlock(action.title);
            }
        }];
        [alert addAction:action];
    }
    
    [viewController presentViewController:alert animated:YES completion:nil];
    
    return alert;
}

#pragma mark --获取titleLabel和messageLabel
- (NSArray *)wxViewArray:(UIView *)root {
    static NSArray *_subviews = nil;
    _subviews = nil;
    for (UIView *v in root.subviews) {
        if (_subviews) {
            break;
        }
        if ([v isKindOfClass:[UILabel class]]) {
            _subviews = root.subviews;
            return _subviews;
        }
        [self wxViewArray:v];
    }
    return _subviews;
}

- (UILabel *)wxTitleLabel {
    return [self wxViewArray:self.view][0];
}

- (UILabel *)wxMessageLabel {
    return [self wxViewArray:self.view][1];
}

@end
