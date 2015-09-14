//
//  TRHeadView.h
//  Day09-03-Weather-UI-V1
//
//  Created by Xiao on 15/6/11.
//  Copyright (c) 2015年 Xiao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRHeadView : UIView


//声明相关lable
//当前温度
@property (nonatomic, strong) UILabel *tempratureLabel;
//最高、最低温度
@property (nonatomic, strong) UILabel *hiloLabel;
//城市
@property (nonatomic, strong) UILabel *cityLabel;
//天气图标
@property (nonatomic, strong) UIImageView *iconView;
//天气描述
@property (nonatomic, strong) UILabel *conditionLabel;

@end
