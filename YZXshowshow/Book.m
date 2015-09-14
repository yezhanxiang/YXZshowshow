//
//  Book.m
//  YZXshowshow
//
//  Created by 展祥叶 on 15/9/13.
//  Copyright (c) 2015年 yzx. All rights reserved.
//

#import "Book.h"

@implementation Book
-(instancetype)initWithDictionary:(NSDictionary *)dict
{
    Book *book = [[Book alloc] init];
    [book setValuesForKeysWithDictionary:dict];
    return book;
}
@end
