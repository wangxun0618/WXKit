//
//  NSObject+WXAuthorization.h
//  WXKit
//
//  Created by xun on 2017/11/15.
//  Copyright © 2017年 WXKit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <Photos/Photos.h>

@interface NSObject (WXAuthorization)

#pragma mark - 获取授权信息

/**
 相机授权

 @param statusBlock 相机授权状态回调
 */
- (void)wx_authorizationStatusForCameraWithStatusBlock:(void(^)(AVAuthorizationStatus status, NSString *statusStr))statusBlock;

/**
 相册授权

 @param statusBlock 相册授权状态回调
 */
- (void)wx_authorizationStatusForPhotoAlbumWithStatusBlock:(void(^)(PHAuthorizationStatus status, NSString *statusStr))statusBlock;

#pragma mark - 保存图片或视频到相册

/**
 保存图片到相册

 @param url 图片URL
 @param successHandler 成功回调
 @param errorHandler 失败回调
 */
- (void)wx_savePhotoToPhotoAlbumWithUrl:(NSString *)url successHandler:(void(^)(void))successHandler errorHandler:(void(^)(void))errorHandler PHOTOS_AVAILABLE_IOS_TVOS(9_0, 10_0);

/**
 保存视频到相册

 @param url 视频URL
 @param successHandler 成功回调
 @param errorHandler 失败回调
 */
- (void)wx_saveVideoToPhotoAlbumWithUrl:(NSString *)url successHandler:(void(^)(void))successHandler errorHandler:(void(^)(void))errorHandler PHOTOS_AVAILABLE_IOS_TVOS(9_0, 10_0);

@end
