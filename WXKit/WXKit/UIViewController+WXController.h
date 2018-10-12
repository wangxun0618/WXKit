//
//  UIViewController+WXController.h
//  WXKit
//
//  Created by xun on 2017/10/18.
//  Copyright © 2017年 WXKit. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (WXController)

//找到当前视图控制器
+ (UIViewController *)wx_currentViewController;

//找到当前导航控制器
+ (UINavigationController *)wx_currentNavigatonController;

/**
 * 在当前视图控制器中添加子控制器，将子控制器的视图添加到 view 中
 *
 * @param childController 要添加的子控制器
 * @param view            要添加到的视图
 */
- (void)wx_addChildController:(UIViewController *)childController intoView:(UIView *)view;

/**
 替换导航栏ViewControllers 中的ViewControllers

 @param index ViewControllers 数组下标
 @param viewController 替换的ViewController
 */
- (void)wx_replaceViewControllerAtIndex:(int)index
                      withViewController:(UIViewController *)viewController;

/**
 移除导航栏ViewControllers 中的ViewControllers

 @param index 数组下标
 */
- (void)removeViewControllerAtIndex:(int)index;

/**
 添加导航栏ViewControllers 中的ViewControllers
 
 @param index ViewControllers 数组下标
 @param viewController 添加的ViewController
 */
- (void)addViewControllerAtIndex:(int)index
                  viewController:(UIViewController *)viewController;



@end
