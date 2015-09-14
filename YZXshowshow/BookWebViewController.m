//
//  BookWebViewController.m
//  YZXshowshow
//
//  Created by 展祥叶 on 15/9/13.
//  Copyright (c) 2015年 yzx. All rights reserved.
//

#import "BookWebViewController.h"
#import "QrCodeViewController.h"

@interface BookWebViewController ()<QrCodeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *bookWebView;

@end

@implementation BookWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.urlStr) {
        self.urlStr = [self.urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:self.urlStr];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.bookWebView loadRequest:request];
    }
    else
    {
        
    }
    
}

-(void)loadQrCodeUrl:(NSString *)urlstr
{
    self.urlStr = urlstr;
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.bookWebView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
