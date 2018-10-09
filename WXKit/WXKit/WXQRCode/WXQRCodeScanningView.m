//
//  WXQRCodeScanningView.m
//  WXKit
//
//  Created by xun on 2017/11/15.
//  Copyright © 2017年 WXKit. All rights reserved.
//

#import "WXQRCodeScanningView.h"

@interface WXQRCodeScanningView ()

@property (strong, nonatomic) UIImageView *lineImageView;

@property (strong, nonatomic) UIImageView *captureImageView;

@end

@implementation WXQRCodeScanningView


#pragma mark ******************* Public method ***********************

- (instancetype)initWithFrame:(CGRect)frame
                 contentFrame:(CGRect)contentFrame
                 captureImage:(NSString *)captureImage
                    lineImage:(NSString *)lineImage
{
    if (self = [super initWithFrame:frame]) {
        self.contentView.frame = contentFrame;
        self.captureImageName = captureImage;
        self.lineImageName = lineImage;
        [self initialization:contentFrame];
    }    
    return self;
}

- (void)wx_startAnimationWithDuration:(NSTimeInterval)duration
{
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position.y"];
    animation.duration = duration;
    animation.repeatCount = MAXFLOAT;
    animation.values = @[@0,@(self.contentView.frame.size.height),@0];
    [self.lineImageView.layer addAnimation:animation forKey:@"move"];
}

- (void)wx_stopAnimation
{
    [self.lineImageView.layer removeAllAnimations];
}



#pragma mark ******************* Private method ***********************

- (void) initialization:(CGRect)contentFrame
{
    //背景
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:0];
    //镂空
    UIBezierPath *circlePath = [UIBezierPath bezierPathWithRect:contentFrame];
    [path appendPath:circlePath];
    [path setUsesEvenOddFillRule:YES];
    
    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.path = path.CGPath;
    fillLayer.fillRule = kCAFillRuleEvenOdd;//中间镂空的关键点 填充规则
    fillLayer.fillColor = [UIColor blackColor].CGColor;
    fillLayer.opacity = 0.6;
    [self.layer addSublayer:fillLayer];
}

- (UIView *)contentView
{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        [self addSubview:_contentView];
    }
    
    return _contentView;
}

- (UIImageView *)captureImageView
{
    if (!_captureImageView) {
        _captureImageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        [self.contentView addSubview:_captureImageView];
    }
    
    return _captureImageView;
}

- (UIImageView *)lineImageView
{
    if (!_lineImageView) {
        
        _lineImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:_lineImageView];
    }
    
    return _lineImageView;
}

- (void)setCaptureImageName:(NSString *)captureImageName
{
    _captureImageName = captureImageName;
    UIImage *image = [UIImage imageNamed:captureImageName];
    self.captureImageView.image = image;
}

- (void)setLineImageName:(NSString *)lineImageName
{
    lineImageName = lineImageName;
    UIImage *image = [UIImage imageNamed:lineImageName];
    self.lineImageView.image = image;
    self.lineImageView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
}

@end
