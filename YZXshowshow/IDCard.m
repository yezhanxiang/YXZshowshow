//
//  IDCard.m
//  YZXshowshow
//
//  Created by 展祥叶 on 15/9/14.
//  Copyright (c) 2015年 yzx. All rights reserved.
//

#import "IDCard.h"

@implementation IDCard
-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    IDCard *card = [[IDCard alloc] init];
    [card setValuesForKeysWithDictionary:dict];
    return card;
}
@end
