//
//  NewsChannelModel.m
//  YZXshowshow
//
//  Created by 展祥叶 on 15/8/31.
//  Copyright (c) 2015年 yzx. All rights reserved.
//

#import "NewsChannelModel.h"

@implementation NewsChannelModel

+(instancetype)channelWithDictionary:(NSDictionary *)dict
{
    NewsChannelModel *channel = [[NewsChannelModel alloc] init];
   [channel setValuesForKeysWithDictionary:dict];
    
    return channel;
}

@end
