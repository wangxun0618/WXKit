//
//  WXQRCodeScanManager.m
//  WXKit
//
//  Created by xun on 2017/11/15.
//  Copyright © 2017年 WXKit. All rights reserved.
//

#import "WXQRCodeScanManager.h"

@interface WXQRCodeScanManager () <AVCaptureMetadataOutputObjectsDelegate, AVCaptureVideoDataOutputSampleBufferDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (nonatomic, strong) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoDataOutput *videoDataOutput;
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *videoPreviewLayer;

@end

static WXQRCodeScanManager *_instance;

@implementation WXQRCodeScanManager

+ (instancetype)sharedManager
{
    return [[self alloc] init];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
        _instance.previewLayerRect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    });
    return _instance;
}

-(id)copyWithZone:(NSZone *)zone {
    return _instance;
}

-(id)mutableCopyWithZone:(NSZone *)zone {
    return _instance;
}

- (void)wx_setupSessionPreset:(NSString *)sessionPreset metadataObjectTypes:(NSArray *)metadataObjectTypes currentController:(UIViewController *)currentController {
    
    if (sessionPreset == nil) {
        NSException *excp = [NSException exceptionWithName:@"SGQRCode" reason:@"setupSessionPreset:metadataObjectTypes:currentController: 方法中的 sessionPreset 参数不能为空" userInfo:nil];
        [excp raise];
    }
    
    if (metadataObjectTypes == nil) {
        NSException *excp = [NSException exceptionWithName:@"SGQRCode" reason:@"setupSessionPreset:metadataObjectTypes:currentController: 方法中的 metadataObjectTypes 参数不能为空" userInfo:nil];
        [excp raise];
    }
    
    if (currentController == nil) {
        NSException *excp = [NSException exceptionWithName:@"SGQRCode" reason:@"setupSessionPreset:metadataObjectTypes:currentController: 方法中的 currentController 参数不能为空" userInfo:nil];
        [excp raise];
    }
    
    // 1、获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 2、创建设备输入流
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    // 3、创建数据输出流
    AVCaptureMetadataOutput *metadataOutput = [[AVCaptureMetadataOutput alloc] init];
    [metadataOutput setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 3(1)、创建设备输出流
    self.videoDataOutput = [[AVCaptureVideoDataOutput alloc] init];
    [_videoDataOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
    
    // 设置扫描范围（每一个取值0～1，以屏幕右上角为坐标原点）
    // 注：这里并没有做处理（可不用设置）; 如需限制扫描范围，打开下一句注释代码并进行相应调试
    // CGRectMake（y的起点/屏幕的高，x的起点/屏幕的宽，扫描的区域的高/屏幕的高，扫描的区域的宽/屏幕的宽)
    //    metadataOutput.rectOfInterest = CGRectMake(0.05, 0.2, 0.7, 0.6);
    
    
    // 4、创建会话对象
    _session = [[AVCaptureSession alloc] init];
    // 会话采集率: AVCaptureSessionPresetHigh
    _session.sessionPreset = sessionPreset;
    
    // 5、添加设备输出流到会话对象
    [_session addOutput:metadataOutput];
    // 5(1)添加设备输出流到会话对象；与 3(1) 构成识别光线强弱
    [_session addOutput:_videoDataOutput];
    
    // 6、添加设备输入流到会话对象
    [_session addInput:deviceInput];
    
    // 7、设置数据输出类型，需要将数据输出添加到会话后，才能指定元数据类型，否则会报错
    // 设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    // @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code,  AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code]
    metadataOutput.metadataObjectTypes = metadataObjectTypes;
    
    // 8、实例化预览图层, 传递_session是为了告诉图层将来显示什么内容
    _videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    // 保持纵横比；填充层边界
    _videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    
    _videoPreviewLayer.frame = _previewLayerRect;
    [currentController.view.layer insertSublayer:_videoPreviewLayer atIndex:0];
    
    // 9、启动会话
    [_session startRunning];
}

- (void)setPreviewLayerRect:(CGRect)previewLayerRect
{
    _previewLayerRect = previewLayerRect;
    _videoPreviewLayer.frame = previewLayerRect;
}

#pragma mark - - - AVCaptureMetadataOutputObjectsDelegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (self.delegate && [self.delegate respondsToSelector:@selector(wx_QRCodeScanManager:didOutputMetadataObjects:)]) {
        [self.delegate wx_QRCodeScanManager:self didOutputMetadataObjects:metadataObjects];
    }
}

#pragma mark - - - AVCaptureVideoDataOutputSampleBufferDelegate的方法
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    // 这个方法会时时调用，但内存很稳定
    CFDictionaryRef metadataDict = CMCopyDictionaryOfAttachments(NULL,sampleBuffer, kCMAttachmentMode_ShouldPropagate);
    NSDictionary *metadata = [[NSMutableDictionary alloc] initWithDictionary:(__bridge NSDictionary*)metadataDict];
    CFRelease(metadataDict);
    NSDictionary *exifMetadata = [[metadata objectForKey:(NSString *)kCGImagePropertyExifDictionary] mutableCopy];
    float brightnessValue = [[exifMetadata objectForKey:(NSString *)kCGImagePropertyExifBrightnessValue] floatValue];
    
    //    NSLog(@"%f",brightnessValue);
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(wx_QRCodeScanManager:brightnessValue:)]) {
        [self.delegate wx_QRCodeScanManager:self brightnessValue:brightnessValue];
    }
}

-(void)setEffectiveRect:(CGRect)effectiveRect
{
    _effectiveRect = effectiveRect;
    AVCaptureMetadataOutput *metadataOutput = _session.outputs[0];
    //要在startRuning后调用 metadataOutputRectOfInterestForRect才管用
    CGRect intertRect = [_videoPreviewLayer metadataOutputRectOfInterestForRect:effectiveRect];
    metadataOutput.rectOfInterest = intertRect;
    
}

- (void)wx_startRunning {
    [_session startRunning];
}

- (void)wx_stopRunning {
    [_session stopRunning];
}

- (void)wx_videoPreviewLayerRemoveFromSuperlayer {
    [_videoPreviewLayer removeFromSuperlayer];
}

- (void)wx_resetSampleBufferDelegate {
    [_videoDataOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
}

- (void)wx_cancelSampleBufferDelegate {
    [_videoDataOutput setSampleBufferDelegate:nil queue:dispatch_get_main_queue()];
}

- (void)wx_palySoundName:(NSString *)name {
    NSString *audioFile = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSURL *fileUrl = [NSURL fileURLWithPath:audioFile];
    
    SystemSoundID soundID = 0;
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
    AudioServicesPlaySystemSound(soundID); // 播放音效
}

void soundCompleteCallback(SystemSoundID soundID, void *clientData){
    
}


#pragma --mark 从相册中读取二维码
- (void)wx_readTheQRCodeFromTheAlbumWithOpenAlbumSuccess:(void(^)(UIImagePickerController *pickerVC))success  error:(void(^)(NSString *errorStr))error
{
    // 判断是否有权限
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType: AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied) {
        if (error) {
            error(@"请先到系统“隐私”中打开相机权限");
        }
        return;
    }
    
    if ( [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary] ) {
        UIImagePickerController *pickerVC = [[UIImagePickerController alloc] init];
        pickerVC.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        pickerVC.delegate = self;
        // 转场动画
        pickerVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        if (success) {
            success(pickerVC);
        }
    } else {
        if (error) {
            error(@"打开相册失败...");
        }
        return ;
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    // 使用 CIDetector 处理 图片
    UIImage *QRCodeImage = info[UIImagePickerControllerOriginalImage];
    CIDetector *detector = [CIDetector detectorOfType: CIDetectorTypeQRCode context: nil options: @{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
    [picker dismissViewControllerAnimated: YES completion:^{
        // 获取结果集(二维码的所有信息都包含在结果集中, 跟扫描出来的二维码的信息是一致的)
        NSArray *result = [detector featuresInImage: [CIImage imageWithCGImage: QRCodeImage.CGImage]];
        
        for (CIQRCodeFeature *feature in result) {
            NSString *obj = feature.messageString;
            // 二维码信息处理
            if (self.delegate && [self.delegate respondsToSelector:@selector(wx_QRCodeScanManager:didOutputFromAlbumMessageString:)]) {
                [self.delegate wx_QRCodeScanManager:self didOutputFromAlbumMessageString:obj];
            }
        }
    }];
}


@end
