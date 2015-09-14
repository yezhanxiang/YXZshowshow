//
//  TRWeather.h
//  Day09-03-Weather-UI-V1
//
//  Created by Xiao on 15/6/11.
//  Copyright (c) 2015年 Xiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRWeather : NSObject

@property (nonatomic, strong) NSString *cityName;//城市名称
@property (nonatomic, strong) NSURL *iconURL;//天气图标的URL地址
@property (nonatomic ,strong) NSString *iconName;
@property (nonatomic, strong) NSString *weatherDesc;//天气描述

@property (nonatomic, assign) float temp;//当前温度
@property (nonatomic, assign) float maxTemp;//最高温
@property (nonatomic, assign) float minTemp;//最低温
@property (nonatomic, strong) NSString *hourly;//小时点数
@property (nonatomic, strong) NSDate *date;//日期-字符串
@property (nonatomic, assign) float time;


//Weather表数据
+ (id)weatherWithCurrentJSON:(NSDictionary *)json;
+ (id)weatherWithHourlyJSON:(NSDictionary *)json;
+ (id)weatherWithDailyJSON:(NSDictionary *)json;

@end
