//
//  BaiduMapController.m
//  YZXshowshow
//
//  Created by 展祥叶 on 15/8/26.
//  Copyright (c) 2015年 yzx. All rights reserved.
//

#import "BaiduMapController.h"
#import <BaiduMapAPI/BMapKit.h>

@interface BaiduMapController ()<BMKGeneralDelegate>
{
    BMKMapManager *_mapManager;
    BMKMapView *_mapView;
}
@end

@implementation BaiduMapController
- (void)viewDidLoad {
    [super viewDidLoad];
    //创建管理者
    _mapManager = [[BMKMapManager alloc]init];
    //获得授权并设置委托
    [_mapManager start:@"LSsUp1B7fGkDeAMLu3rGLQrh" generalDelegate:self];
    //创建地图视图
    _mapView = [[BMKMapView alloc]initWithFrame:self.view.bounds];
    [self.view addSubview:_mapView];
}

/**
 *返回网络错误
 *@param iError 错误号
 */
- (void)onGetNetworkState:(int)iError
{
    if (iError == 0) {
        NSLog(@"网络连接正常");
    }else{
        NSLog(@"网络连接失败");
    }
}

/**
 *返回授权验证错误
 *@param iError 错误号 : 为0时验证通过，具体参加BMKPermissionCheckResultCode
 */
- (void)onGetPermissionState:(int)iError
{
    if (iError == 0) {
        NSLog(@"授权成功!");
    }else{
        NSLog(@"没有使用权限!");
    }
}

-(void)viewWillDisappear:(BOOL)animated
{
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}
@end
