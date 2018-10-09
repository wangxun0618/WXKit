//
//  UIViewController+WXController.m
//  WXKit
//
//  Created by xun on 2017/10/18.
//  Copyright © 2017年 WXKit. All rights reserved.
//

#import "UIViewController+WXController.h"

@implementation UIViewController (WXController)

+ (UIViewController *)wx_findBestViewController:(UIViewController *)vc
{
    if (vc.presentedViewController)
    {
        return [self wx_findBestViewController:vc.presentedViewController];
    }
    else if ([vc isKindOfClass:[UISplitViewController class]])
    {
        UISplitViewController* svc = (UISplitViewController*) vc;
        if (svc.viewControllers.count > 0)
        {
            return [self wx_findBestViewController:svc.viewControllers.lastObject];
        }
        else
        {
            return vc;
        }
        
    }
    else if ([vc isKindOfClass:[UINavigationController class]])
    {
        UINavigationController* svc = (UINavigationController*) vc;
        if (svc.viewControllers.count > 0)
        {
            return [self wx_findBestViewController:svc.topViewController];
        }
        else
        {
            return vc;
        }
        
    }
    else if ([vc isKindOfClass:[UITabBarController class]])
    {
        UITabBarController* svc = (UITabBarController *)vc;
        if (svc.viewControllers.count > 0)
        {
            return [self wx_findBestViewController:svc.selectedViewController];
        }
        else
        {
            return vc;
        }
        
    }
    else
    {
        return vc;
    }
}

+ (UIViewController *)wx_currentViewController
{
    UIViewController *viewController = [[UIApplication sharedApplication].delegate window].rootViewController;
    
    return [UIViewController wx_findBestViewController:viewController];
}

+ (UINavigationController *)wx_currentNavigatonController {
    
    UIViewController * currentViewController =  [UIViewController wx_currentViewController];
    
    return currentViewController.navigationController;
}

- (void)wx_addChildController:(UIViewController *)childController intoView:(UIView *)view  {
    
    [self addChildViewController:childController];
    
    [view addSubview:childController.view];
    
    [childController didMoveToParentViewController:self];
}

//替换导航栏数组中的ViewController
- (void)wx_replaceViewControllerAtIndex:(int)index
                      withViewController:(UIViewController *)viewController
{
    NSMutableArray* navArray = [[NSMutableArray alloc] initWithArray:self.navigationController.viewControllers];
    [navArray replaceObjectAtIndex:index withObject:viewController];
    [self.navigationController setViewControllers:navArray animated:YES];
}

@end
