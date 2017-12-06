//
//  WXQRCodeScanManager.h
//  WXKit
//
//  Created by xun on 2017/11/15.
//  Copyright © 2017年 WXKit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
@class WXQRCodeScanManager;

@protocol WXQRCodeScanManagerDelegate <NSObject>

@required
/** 二维码扫描获取数据的回调方法 (metadataObjects: 扫描二维码数据信息) */
- (void)wx_QRCodeScanManager:(WXQRCodeScanManager *)scanManager
    didOutputMetadataObjects:(NSArray *)metadataObjects;

@optional
/** 根据光线强弱值打开手电筒的方法 (brightnessValue: 光线强弱值) */
- (void)wx_QRCodeScanManager:(WXQRCodeScanManager *)scanManager
             brightnessValue:(CGFloat)brightnessValue;

/** 从相册中读取二维码结果回调 */
- (void)wx_QRCodeScanManager:(WXQRCodeScanManager *)scanManager
didOutputFromAlbumMessageString:(NSString *)messageString;

@end


@interface WXQRCodeScanManager : NSObject

@property (nonatomic, weak) id<WXQRCodeScanManagerDelegate> delegate;

/** 扫描有效区域 **/
@property (nonatomic) CGRect effectiveRect;

@property (nonatomic) CGRect previewLayerRect;

/** 快速创建单利方法 **/
+ (instancetype)sharedManager;

/**
 创建扫描二维码会话对象以及会话采集数据类型和扫码支持的编码格式的设置，必须实现的方法
 
 @param sessionPreset 会话采集数据类型
 @param metadataObjectTypes 扫码支持的编码格式
 @param currentController WXQRCodeScanManager 所在控制器
 */
- (void)wx_setupSessionPreset:(NSString *)sessionPreset
       metadataObjectTypes:(NSArray *)metadataObjectTypes
         currentController:(UIViewController *)currentController;

/** 从相册中读取二维码*/
- (void)wx_readTheQRCodeFromTheAlbumWithOpenAlbumSuccess:(void(^)(UIImagePickerController *pickerVC))success  error:(void(^)(NSString *errorStr))error;

/** 开启会话对象扫描 */
- (void)wx_startRunning;

/** 停止会话对象扫描 */
- (void)wx_stopRunning;

/** 移除 videoPreviewLayer 对象 */
- (void)wx_videoPreviewLayerRemoveFromSuperlayer;

/** 播放音效文件 */
- (void)wx_palySoundName:(NSString *)name;

/** 重置根据光线强弱值打开手电筒的 delegate 方法 */
- (void)wx_resetSampleBufferDelegate;

/** 取消根据光线强弱值打开手电筒的 delegate 方法 */
- (void)wx_cancelSampleBufferDelegate;

@end
