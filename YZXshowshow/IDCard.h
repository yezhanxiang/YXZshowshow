//
//  IDCard.h
//  YZXshowshow
//
//  Created by 展祥叶 on 15/9/14.
//  Copyright (c) 2015年 yzx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IDCard : NSObject
@property(nonatomic,strong)NSString *sex;
@property(nonatomic,strong)NSString *birthday;
@property(nonatomic,strong)NSString *address;

-(instancetype)initWithDictionary:(NSDictionary *)dict;
@end
