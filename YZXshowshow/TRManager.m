//
//  TRManager.m
//  Day09-03-Weather-UI-V1
//
//  Created by Xiao on 15/6/11.
//  Copyright (c) 2015年 Xiao. All rights reserved.
//

#import "TRManager.h"

@implementation TRManager

//单例
+ (id)sharedWeatherDataCenter
{
    static TRManager *sharedDataCenter = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedDataCenter = [[self alloc] init];
    });
    
    return sharedDataCenter;
}


- (id)init
{
    if (self = [super init]) {
        self.houriyWeathers = [NSArray new];
        self.dailyWeathers = [NSArray new];
    }
    return self;
}

@end
