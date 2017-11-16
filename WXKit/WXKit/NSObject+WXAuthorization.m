//
//  NSObject+WXAuthorization.m
//  WXKit
//
//  Created by xun on 2017/11/15.
//  Copyright © 2017年 WXKit. All rights reserved.
//

#import "NSObject+WXAuthorization.h"

@implementation NSObject (WXAuthorization)

#pragma mark - 获取授权信息

- (void)wx_authorizationStatusForCameraWithStatusBlock:(void(^)(AVAuthorizationStatus status, NSString *statusStr))statusBlock
{
    // 判断授权状态
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted) { //因为系统原因, 无法访问相机
        statusBlock(authStatus, @"因为系统原因, 无法访问相机");
        return;
    } else if (authStatus == AVAuthorizationStatusDenied) { // 用户拒绝当前应用访问相机
        statusBlock(authStatus, @"用户拒绝当前应用访问相机");
        return;
    } else if (authStatus == AVAuthorizationStatusAuthorized) { // 用户允许当前应用访问相机
       statusBlock(authStatus, @"用户允许当前应用访问相机");
        return;
    } else if (authStatus == AVAuthorizationStatusNotDetermined) { // 用户还没有做出选择
        // 弹框请求用户授权
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if (granted) {
                // 用户接受
                statusBlock(AVAuthorizationStatusAuthorized, @"用户允许当前应用访问相机");
            } else {
                statusBlock(AVAuthorizationStatusDenied, @"用户拒绝当前应用访问相机");
            }
        }];
    }
}

- (void)wx_authorizationStatusForPhotoAlbumWithStatusBlock:(void(^)(PHAuthorizationStatus status, NSString *statusStr))statusBlock
{
    PHAuthorizationStatus authStatus = [PHPhotoLibrary authorizationStatus];
    
    if (authStatus == PHAuthorizationStatusAuthorized) { // 用户允许当前应用访问相册
        statusBlock(authStatus, @"用户允许当前应用访问相册");
        return;
    } else if (authStatus == PHAuthorizationStatusDenied) {// 用户拒绝当前应用访问相册
        statusBlock(authStatus, @"用户拒绝当前应用访问相册");
        return;
    } else if (authStatus == PHAuthorizationStatusRestricted) { // 这个应用程序未被授权访问图片数据。用户不能更改该应用程序的状态,可能是由于活动的限制,如家长控制到位。
        statusBlock(authStatus, @"用户拒绝当前应用访问相册");
        return;
    } else if (authStatus == PHAuthorizationStatusNotDetermined) { // 用户还没有做出选择
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
            if (status == PHAuthorizationStatusAuthorized) {
                statusBlock(authStatus, @"用户允许当前应用访问相册");
            } else if (status == PHAuthorizationStatusDenied) {
                statusBlock(authStatus, @"用户拒绝当前应用访问相册");
            }
        }];
    }
}

#pragma mark - 保存图片或视频到相册

- (void)wx_savePhotoToPhotoAlbumWithUrl:(NSString *)url successHandler:(void(^)(void))successHandler errorHandler:(void(^)(void))errorHandler
{
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        if (@available(iOS 9.0, *)) {
            PHAssetCreationRequest *assetCreationRequest = [PHAssetCreationRequest creationRequestForAssetFromImageAtFileURL:[NSURL URLWithString:url]];
            [self creatPhotoAlumFile:assetCreationRequest];
        } else {
            // Fallback on earlier versions
        }
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            successHandler();
        } else {
            errorHandler();
        }
    }];
    
}

- (void)wx_saveVideoToPhotoAlbumWithUrl:(NSString *)url successHandler:(void(^)(void))successHandler errorHandler:(void(^)(void))errorHandler
{
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        if (@available(iOS 9.0, *)) {
            PHAssetCreationRequest *assetCreationRequest = [PHAssetCreationRequest creationRequestForAssetFromVideoAtFileURL:[NSURL URLWithString:url]];
            [self creatPhotoAlumFile:assetCreationRequest];
        } else {
            // Fallback on earlier versions
        }
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (success) {
            successHandler();
        } else {
            errorHandler();
        }
    }];
}

- (void)creatPhotoAlumFile:(PHAssetCreationRequest *)assetCreationRequest PHOTOS_AVAILABLE_IOS_TVOS(9_0, 10_0)
{
    NSString *executableFile = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    PHAssetCollectionChangeRequest *assetCollectionChangeRequest = nil;
    
    PHAssetCollection *assetCollection = [self fetchAssetCollection:executableFile];
    
    if (assetCollection) {
        assetCollectionChangeRequest = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:assetCollection];
    } else {
        assetCollectionChangeRequest = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:executableFile];
    }
    
    [assetCollectionChangeRequest addAssets:@[assetCreationRequest.placeholderForCreatedAsset]];
}

- (PHAssetCollection *)fetchAssetCollection:(NSString *)title
{
    PHFetchResult *result = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *assetCollection in result) {
        if ([title isEqualToString:assetCollection.localizedTitle]) {
            return assetCollection;
        }
    }
    return nil;
}




@end
