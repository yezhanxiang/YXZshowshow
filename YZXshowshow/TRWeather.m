//
//  TRWeather.m
//  Day09-03-Weather-UI-V1
//
//  Created by Xiao on 15/6/11.
//  Copyright (c) 2015年 Xiao. All rights reserved.
//

#import "TRWeather.h"


//天气图标url前缀
static NSString * const iconURLString = @"http://cdn.worldweatheronline.net/images/wsymbols01_png_64/wsymbol_";

@implementation TRWeather

//解析current_condition部分数据
+ (id)weatherWithCurrentJSON:(NSDictionary *)json
{
    return [[self alloc] initWithCurrentJSON:json];
}

- (id)initWithCurrentJSON:(NSDictionary *)json{
    if (self = [super init]) {
        
        self.iconURL     = json[@"data"][@"current_condition"][0][@"weatherIconUrl"][0][@"value"];
        self.iconName    = [self imageMap][self.iconURL];
        self.weatherDesc = json[@"data"][@"current_condition"][0][@"weatherDesc"][0][@"value"];
        
        self.temp     = [json[@"data"][@"current_condition"][0][@"temp_C"] floatValue];
        self.maxTemp  = [json[@"data"][@"weather"][0][@"maxtempC"] floatValue];
        self.minTemp  = [json[@"data"][@"weather"][0][@"mintempC"] floatValue];
        self.cityName = json[@"data"][@"request"][0][@"query"];
    }
    
    return self;
}

//解析weather中hourly部分数据
+ (id)weatherWithHourlyJSON:(NSDictionary *)json
{
    return [[self alloc] initWithHourlyJSON:(NSDictionary *)json];
}

- (id)initWithHourlyJSON:(NSDictionary *)json
{
    if (self = [super init]) {
        //self.weatherDesc = json[@"weatherDesc"][0][@"value"];
        self.temp = [json[@"tempC"] floatValue];

        self.time = [json[@"time"] floatValue] / 100;
        
        self.iconURL = json[@"weatherIconUrl"][0][@"value"];
        //  配置天气图片
        self.iconName = [self imageMap][self.iconURL];
    }
    return self;
}


//解析后几天数据
+ (id)weatherWithDailyJSON:(NSDictionary *)json
{
    return [[self alloc] initWithDailyJSON:json];
}

- (id)initWithDailyJSON:(NSDictionary *)json
{
    if (self = [super init]) {
        self.date = json[@"date"];
        self.minTemp = [json[@"mintempC"] floatValue];
        self.maxTemp = [json[@"maxtempC"] floatValue];
        
        self.iconURL = json[@"hourly"][0][@"weatherIconUrl"][0][@"value"];
        //  配置天气图片
        self.iconName = [self imageMap][self.iconURL];
    }
    return self;
}

// 图片名 - iconCode的映射
- (NSDictionary *)imageMap{
    
    return @{
             [NSString stringWithFormat:@"%@0001_sunny.png",iconURLString]:@"weather-clear.png",
             [NSString stringWithFormat:@"%@0003_white_cloud.png",iconURLString]:@"weather-few.png",
             [NSString stringWithFormat:@"%@0004_black_low_cloud.png",iconURLString]:@"weather-scattered.png",
             [NSString stringWithFormat:@"%@0004_black_low_cloud.png",iconURLString]:@"weather-broken",
             [NSString stringWithFormat:@"%@0009_light_rain_showers.png",iconURLString]:@"weather-shower",
             [NSString stringWithFormat:@"%@0025_light_rain_showers_night.png",iconURLString]:@"weather-rain",
             @"11d":@"weather-tstorm",
             @"13d":@"weather-snow",
             [NSString stringWithFormat:@"%@0006_mist.png",iconURLString]
             :@"weather-mist",
             [NSString stringWithFormat:@"%@0008_clear_sky_night.png",iconURLString]:@"weather-moon",
             @"02n":@"weather-few-night",
             @"03n":@"weather-few-night",
             [NSString stringWithFormat:@"%@0002_sunny_intervals.png",iconURLString]:@"weather-broken",
             @"09n":@"weather-shoer",
             [NSString stringWithFormat:@"%@0025_light_rain_showers_night.png",iconURLString]:@"weather-rain-night",
             @"11n":@"weather-tstorm",
             @"13n":@"weather-snow",
             @"50n":@"weather-mist"
             };
}

@end
