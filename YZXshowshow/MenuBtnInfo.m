//
//  MenuBtnInfo.m
//  YZXshowshow
//
//  Created by 展祥叶 on 15/8/28.
//  Copyright (c) 2015年 yzx. All rights reserved.
//

#import "MenuBtnInfo.h"

@implementation MenuBtnInfo

+(NSArray *)ArrayOfMenuBtn
{
    //-----------第1行按钮-------------------
    
    MenuBtnInfo *btn = [[MenuBtnInfo alloc] init];
    btn.imageName = @"旅游";
    btn.btnTitle = @"旅游景点";
    
    MenuBtnInfo *btn2 = [[MenuBtnInfo alloc] init];
    btn2.imageName = @"新闻";
    btn2.btnTitle = @"新闻";
    
    MenuBtnInfo *btn3 = [[MenuBtnInfo alloc] init];
    btn3.imageName = @"天气";
    btn3.btnTitle = @"天气";
    
    MenuBtnInfo *btn4 = [[MenuBtnInfo alloc] init];
    btn4.imageName = @"淘宝";
    btn4.btnTitle = @"淘宝";
    
    //-----------第2行按钮-------------------
    
    MenuBtnInfo *btn5 = [[MenuBtnInfo alloc] init];
    btn5.imageName = @"ip";
    btn5.btnTitle = @"IP查询";
    
    MenuBtnInfo *btn6 = [[MenuBtnInfo alloc] init];
    btn6.imageName = @"身份证";
    btn6.btnTitle = @"身份证查询";
    
    MenuBtnInfo *btn7 = [[MenuBtnInfo alloc] init];
    btn7.imageName = @"天猫";
    btn7.btnTitle = @"天猫";
    
    
    //-----------第3行按钮-------------------
    
    NSArray *array = [[NSArray alloc] initWithObjects:[NSArray arrayWithObjects:btn,btn2,btn3,btn4, nil],[NSArray arrayWithObjects:btn5,btn6,btn7,btn4, nil],nil];
    
    return array;
}
@end
