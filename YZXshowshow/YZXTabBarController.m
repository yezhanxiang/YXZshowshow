//
//  YZXTabBarController.m
//  YZXshowshow
//
//  Created by 展祥叶 on 15/8/14.
//  Copyright (c) 2015年 yzx. All rights reserved.
//

#import "YZXTabBarController.h"
#import "ViewController.h"

@interface YZXTabBarController ()

@end

@implementation YZXTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    //背景
    [self.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbarBG"]];
    //[self.tabBar setBackgroundColor:[UIColor colorWithRed:37 /255.0f green:163 / 255.0f blue:235 / 255.0f alpha:1.0]];
    UIView *bgView = [[UIView alloc] initWithFrame:self.tabBar.bounds];
    [bgView setBackgroundColor:[UIColor colorWithRed:37 /255.0f green:163 / 255.0f blue:235 / 255.0f alpha:1.0]];
    [self.tabBar insertSubview:bgView atIndex:0];
    self.tabBar.translucent = YES;
    //
    [self createUITableBarItem];
}

//创建选项卡
-(void)createUITableBarItem
{
    //主页VC
    UINavigationController *homeNav = [[self storyboard] instantiateViewControllerWithIdentifier:@"HomeNavigationController"];
    ViewController *homeVC = (ViewController *)homeNav.topViewController;
    homeVC.title = @"主页";
    homeVC.tabBarItem.title = @"菜单";
    homeVC.tabBarItem.image = [UIImage imageNamed:@"home"];
    homeVC.tabBarItem.selectedImage = [UIImage imageNamed:@"home_sel"];
    //设置tabbar字体颜色
    [homeVC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor],NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    [homeVC.tabBarItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor],NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    
    //我的
    UINavigationController *meNav = [[self storyboard] instantiateViewControllerWithIdentifier:@"MeNavigationController"];
    
    //设置VC
    UINavigationController *setNav = [[self storyboard] instantiateViewControllerWithIdentifier:@"SetNavigationController"];
    
    
    //管理VC的数组
    NSArray *VC_arr = @[homeNav,meNav,setNav];
    self.viewControllers = VC_arr;
}

@end
