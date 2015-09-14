//
//  IPModel.h
//  YZXshowshow
//
//  Created by 展祥叶 on 15/9/14.
//  Copyright (c) 2015年 yzx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IPModel : NSObject
@property(nonatomic,strong)NSString *ip;
@property(nonatomic,strong)NSString *country;
@property(nonatomic,strong)NSString *province;
@property(nonatomic,strong)NSString *city;
@property(nonatomic,strong)NSString *district;
@property(nonatomic,strong)NSString *carrier;

-(instancetype)initWithDictionary:(NSDictionary *)dict;
@end
