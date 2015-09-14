//
//  Book.h
//  YZXshowshow
//
//  Created by 展祥叶 on 15/9/13.
//  Copyright (c) 2015年 yzx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Book : NSObject
@property(nonatomic,strong)NSString *bookUrl;
@property(nonatomic,strong)NSString *title;
@property(nonatomic,strong)NSString *headImage;
@property(nonatomic,strong)NSString *userName;
@property(nonatomic,strong)NSString *userHeadImg;
@property(nonatomic,strong)NSString *startTime;
@property(nonatomic,assign)NSInteger routeDays;
@property(nonatomic,assign)NSInteger bookImgNum;
@property(nonatomic,assign)NSInteger viewCount;
@property(nonatomic,assign)NSInteger likeCount;
@property(nonatomic,assign)NSInteger commentCount;
@property(nonatomic,strong)NSString *text;
@property(nonatomic,assign)BOOL elite;

-(instancetype)initWithDictionary:(NSDictionary *)dict;

@end
