//
//  TaoBaoViewController.m
//  YZXshowshow
//
//  Created by 展祥叶 on 15/9/8.
//  Copyright (c) 2015年 yzx. All rights reserved.
//

#import "TaoBaoViewController.h"
#import "NJKWebViewProgressView.h"
#import "NJKWebViewProgress.h"

#define TAOBAOURL @"https://www.taobao.com/"

@interface TaoBaoViewController ()<UIWebViewDelegate,NJKWebViewProgressDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property(strong,nonatomic)NJKWebViewProgressView *progressView;
@property(strong,nonatomic)NJKWebViewProgress *progressProxy;

@end

@implementation TaoBaoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.progressProxy = [[NJKWebViewProgress alloc] init];
    self.webView.delegate = _progressProxy;
    self.progressProxy.webViewProxyDelegate = self;
    self.progressProxy.progressDelegate = self;
    
    CGFloat progressBarHeight = 2.f;
    CGRect navigationBarBounds = self.navigationController.navigationBar.bounds;
    CGRect barFrame = CGRectMake(0, navigationBarBounds.size.height - progressBarHeight, navigationBarBounds.size.width, progressBarHeight);
    self.progressView = [[NJKWebViewProgressView alloc] initWithFrame:barFrame];
    //self.progressView.backgroundColor = [UIColor blackColor];
    [self.progressView.progressBarView setBackgroundColor:[UIColor whiteColor]];//进度条的颜色
    self.progressView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.webURL]];
    [self.webView loadRequest:request];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar addSubview:self.progressView];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [self.progressView removeFromSuperview];
}

#pragma mark - NJKWebViewProgressDelegate
-(void)webViewProgress:(NJKWebViewProgress *)webViewProgress updateProgress:(float)progress
{
    [self.progressView setProgress:progress animated:YES];
    self.title = [self.webView stringByEvaluatingJavaScriptFromString:@"淘宝"];
}

- (IBAction)goBackHomeMenu:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
