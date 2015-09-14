//
//  QrCodeViewController.h
//  YZXshowshow
//
//  Created by 展祥叶 on 15/9/14.
//  Copyright (c) 2015年 yzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol QrCodeViewControllerDelegate <NSObject>

-(void)loadQrCodeUrl:(NSString *)urlstr;

@end

@interface QrCodeViewController : UIViewController
@property(weak,nonatomic)id<QrCodeViewControllerDelegate> delegate;
@end
