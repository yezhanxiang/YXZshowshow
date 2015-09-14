//
//  IPModel.m
//  YZXshowshow
//
//  Created by 展祥叶 on 15/9/14.
//  Copyright (c) 2015年 yzx. All rights reserved.
//

#import "IPModel.h"

@implementation IPModel

-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    IPModel *ip = [[IPModel alloc] init];
    [ip setValuesForKeysWithDictionary:dict];
    return ip;
}

@end
