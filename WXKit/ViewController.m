//
//  ViewController.m
//  WXKit
//
//  Created by xun on 2017/11/9.
//  Copyright © 2017年 WXKit. All rights reserved.
//

#import "ViewController.h"
#import "WXKit.h"
#import "ViewControllerOne.h"


@interface ViewController () <WXQRCodeScanManagerDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self generatedQRCode];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 32, 100, 100);
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    [button addClickTargetBlock:^(UIButton *sender) {

        sender.selected = !sender.selected;
        
    }];
}

- (void)generatedQRCode
{
    UIImage *image = [WXQRCodeGenerateManager wx_generateWithDefaultQRCodeData:@"12345" imageViewWidth:50];
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    imageView.frame = CGRectMake(100, 300, 150, 150);
    [self.view addSubview:imageView];
    
}

- (void)scanning
{
    WXQRCodeScanningView *scanningView = [[WXQRCodeScanningView alloc] initWithFrame:self.view.bounds contentFrame:CGRectMake(20, 200, KSCREEN_WIDTH-40, KSCREEN_WIDTH-40) captureImage:@"capture" lineImage:@"scanner"];
    
    [self.view addSubview:scanningView];
    [scanningView wx_startAnimationWithDuration:3];
    NSArray *arr = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    WXQRCodeScanManager *manage = [WXQRCodeScanManager sharedManager];
    manage.delegate = self;
    [manage wx_setupSessionPreset:AVCaptureSessionPreset1920x1080 metadataObjectTypes:arr currentController:self];
    
    manage.effectiveRect = scanningView.contentView.frame;
}

-(void)wx_QRCodeScanManager:(WXQRCodeScanManager *)scanManager didOutputMetadataObjects:(NSArray *)metadataObjects
{
    NSLog(@"metadataObjects %@", metadataObjects);
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


- (BOOL)shouldAutorotate
{
    return NO;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskLandscapeRight;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeRight;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
