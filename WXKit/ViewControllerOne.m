//
//  ViewControllerOne.m
//  WXKit
//
//  Created by xun on 2017/11/9.
//  Copyright © 2017年 WXKit. All rights reserved.
//

#import "ViewControllerOne.h"
#import "WXKit.h"

@interface ViewControllerOne ()

@end

@implementation ViewControllerOne

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor yellowColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 132, 100, 100);
    button.backgroundColor = [UIColor redColor];
    [self.view addSubview:button];
    [button countdownTimerWithInterval:60 progressBlock:^(UIButton *sender, NSInteger time) {
        NSLog(@"%@, %ld",sender, (long)time);
        NSString  *strTime = [NSString stringWithFormat:@"%ld 秒",(long)time];
        [sender setTitle:strTime forState:UIControlStateNormal];
    } successBlock:^(UIButton *sender) {
        NSLog(@"倒计时完成");
    }];
    
    
//    [UIAlertController wx_alertControllerWithTitle:@"提示" message:@"输入框" textFieldNum:3 presentViewController:self sureTitle:@"sure" cancelTitle:@"cancel" textFieldBlock:^(NSArray *array) {
//        NSLog(@"-------%lu",(unsigned long)array.count);
//        UITextField *textField = array[0];
//        textField.placeholder = @"输入框";
//
//    } sureBlock:^(UIAlertAction *action) {
//        NSLog(@"确定");
//    } cancelBlock:^(UIAlertAction *action) {
//        NSLog(@"取消");
//    }];
//    [button addClickTargetBlock:^(UIButton *sender) {
//
//
//    }];
    
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
//    [UIAlertController wx_alertControllerWithTitle:@"提示" message:@"输入框" textFieldNum:3 presentViewController:self sureTitle:@"sure" cancelTitle:@"cancel" textFieldBlock:^(NSArray *array) {
//        NSLog(@"-------%lu",(unsigned long)array.count);
//        UITextField *textField = array[0];
//        textField.placeholder = @"输入框";
//
//    } sureBlock:^(UIAlertAction *action) {
//        NSLog(@"确定");
//    } cancelBlock:^(UIAlertAction *action) {
//        NSLog(@"取消");
//    }];

}

- (void)log
{
    NSLog(@"打印");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
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

- (void)dealloc
{
    NSLog(@">>>>>>>%@",self);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
