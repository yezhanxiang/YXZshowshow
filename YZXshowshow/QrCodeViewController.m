//
//  QrCodeViewController.m
//  YZXshowshow
//
//  Created by 展祥叶 on 15/9/14.
//  Copyright (c) 2015年 yzx. All rights reserved.
//

#import "QrCodeViewController.h"
#import "BookWebViewController.h"
#import "SYQRCodeViewController.h"

@interface QrCodeViewController ()

@end

@implementation QrCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //扫描二维码
    SYQRCodeViewController *qrcodevc = [[SYQRCodeViewController alloc] init];
    
    qrcodevc.SYQRCodeSuncessBlock = ^(SYQRCodeViewController *aqrvc,NSString *qrString){
//        self.saomiaoLabel.text = qrString;
        //[aqrvc dismissViewControllerAnimated:NO completion:nil];
        [aqrvc.navigationController popViewControllerAnimated:YES];
        BookWebViewController *bookWebVC = [[self storyboard] instantiateViewControllerWithIdentifier:@"BookWebViewController"];
        [self.delegate loadQrCodeUrl:qrString];

        [self.navigationController pushViewController:bookWebVC animated:YES];
    };
    qrcodevc.SYQRCodeFailBlock = ^(SYQRCodeViewController *aqrvc){
//        self.saomiaoLabel.text = @"fail~";
        [aqrvc dismissViewControllerAnimated:NO completion:nil];
    };
    qrcodevc.SYQRCodeCancleBlock = ^(SYQRCodeViewController *aqrvc){
        [aqrvc dismissViewControllerAnimated:NO completion:nil];
//        self.saomiaoLabel.text = @"cancle~";
    };
    //[self presentViewController:qrcodevc animated:YES completion:nil];
    [self.navigationController pushViewController:qrcodevc animated:YES];
    
    
}

-(void)loadQrCodeUrl:(NSString *)urlstr
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
