//
//  UIView+WXView.h
//  WXKit
//
//  Created by xun on 2017/10/18.
//  Copyright © 2017年 WXKit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, WXBorderSideType) {
    WXBorderSideTypeAll  = 0,
    WXBorderSideTypeTop = 1 << 0,
    WXBorderSideTypeBottom = 1 << 1,
    WXBorderSideTypeLeft = 1 << 2,
    WXBorderSideTypeRight = 1 << 3,
};

typedef void (^TapActionBlock)(UITapGestureRecognizer *gestureRecoginzer);
typedef void (^LongPressActionBlock)(UILongPressGestureRecognizer *gestureRecoginzer);

@interface UIView (WXView)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize  size;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign, readonly) CGFloat maxX;
@property (nonatomic, assign, readonly) CGFloat maxY;
@property (nonatomic, assign, readonly) CGFloat midX;
@property (nonatomic, assign, readonly) CGFloat midY;

//截取成图片
- (UIImage *)wx_snapshotImage;

/**
 *  @brief  添加tap手势
 *
 *  @param block 代码块
 */
- (void)wx_addTapActionWithBlock:(TapActionBlock)block;

/**
 *  @brief  添加长按手势
 *
 *  @param block 代码块
 */
- (void)wx_addLongPressActionWithBlock:(LongPressActionBlock)block;

/** 找到指定类名的subView */
- (UIView *)wx_findSubViewWithClass:(Class)clazz;
- (NSArray *)wx_findAllSubViewsWithClass:(Class)clazz;

/** 找到指定类名的superView对象 */
- (UIView *)wx_findSuperViewWithClass:(Class)clazz;

/** 找到view上的第一响应者 */
- (UIView *)wx_findFirstResponder;

/** 找到当前view所在的viewcontroler */
- (UIViewController *)wx_findViewController;

//所有子视图
- (NSArray *)wx_allSubviews;

//移除所有子视图
- (void)wx_removeAllSubviews;

//添加边框
- (UIView *)borderForColor:(UIColor *)color
               borderWidth:(CGFloat)borderWidth
                 lineSpace:(CGFloat)lineSpace
                borderType:(WXBorderSideType)borderType;


//xib加载视图
+ (instancetype)wx_loadViewFromNib;
+ (instancetype)wx_loadViewFromNibWithName:(NSString *)nibName;
+ (instancetype)wx_loadViewFromNibWithName:(NSString *)nibName owner:(id)owner;
+ (instancetype)wx_loadViewFromNibWithName:(NSString *)nibName owner:(id)owner bundle:(NSBundle *)bundle;

/**
 * 给UIView 设置圆角
 */
@property (assign,nonatomic) IBInspectable NSInteger cornerRadius;
@property (assign,nonatomic) IBInspectable BOOL  masksToBounds;

/**
 * 设置 view的 边框颜色(选择器和Hex颜色)
 * 以及 边框的宽度
 */
@property (assign,nonatomic) IBInspectable NSInteger borderWidth;
@property (strong,nonatomic) IBInspectable NSString  *borderHexRgb;
@property (strong,nonatomic) IBInspectable UIColor   *borderColor;

/**  设置圆角  */
- (void)rounded:(CGFloat)cornerRadius;

/**  设置圆角和边框  */
- (void)rounded:(CGFloat)cornerRadius width:(CGFloat)borderWidth color:(UIColor *_Nullable)borderColor;

/**  设置边框  */
- (void)border:(CGFloat)borderWidth color:(UIColor *_Nullable)borderColor;

/**   给哪几个角设置圆角  */
-(void)round:(CGFloat)cornerRadius RectCorners:(UIRectCorner)rectCorner;

/**  设置阴影  */
-(void)shadow:(UIColor *_Nullable)shadowColor opacity:(CGFloat)opacity radius:(CGFloat)radius offset:(CGSize)offset;

@end
