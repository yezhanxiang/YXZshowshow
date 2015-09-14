//
//  TRManager.h
//  Day09-03-Weather-UI-V1
//
//  Created by Xiao on 15/6/11.
//  Copyright (c) 2015年 Xiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRManager : NSObject

//每隔几小时的天气
@property (nonatomic, strong) NSArray *houriyWeathers;
//后几天的天气
@property (nonatomic, strong) NSArray *dailyWeathers;

+ (id)sharedWeatherDataCenter;

@end
