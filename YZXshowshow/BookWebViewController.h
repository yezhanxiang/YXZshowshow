//
//  BookWebViewController.h
//  YZXshowshow
//
//  Created by 展祥叶 on 15/9/13.
//  Copyright (c) 2015年 yzx. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol BookWebViewControllerDelegate <NSObject>

-(void)loadQrCodeUrl:(NSString *)urlstr;

@end

@interface BookWebViewController : UIViewController
@property(nonatomic,strong)NSString *urlStr;
@property(weak,nonatomic)id<BookWebViewControllerDelegate> delegate;

@end
