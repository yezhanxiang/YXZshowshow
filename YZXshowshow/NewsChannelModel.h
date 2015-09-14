//
//  NewsChannelModel.h
//  YZXshowshow
//
//  Created by 展祥叶 on 15/8/31.
//  Copyright (c) 2015年 yzx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NewsChannelModel : NSObject
@property(strong,nonatomic)NSString *channelId;//频道编号
@property(strong,nonatomic)NSString *name;//频道名字

+(instancetype)channelWithDictionary:(NSDictionary *)dict;

@end
