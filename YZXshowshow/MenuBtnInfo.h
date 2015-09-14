//
//  MenuBtnInfo.h
//  YZXshowshow
//
//  Created by 展祥叶 on 15/8/28.
//  Copyright (c) 2015年 yzx. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenuBtnInfo : NSObject
@property(copy,nonatomic)NSString *imageName;
@property(copy,nonatomic)NSString *btnTitle;

+(NSArray *)ArrayOfMenuBtn;
@end
