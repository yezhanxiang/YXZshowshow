//
//  NewsChannelCell.h
//  YZXshowshow
//
//  Created by 展祥叶 on 15/8/31.
//  Copyright (c) 2015年 yzx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsChannelModel.h"

@interface NewsChannelCell : UITableViewCell
@property(strong,nonatomic)NewsChannelModel *channel;

+(instancetype)initNewsChannelCell:(UITableView *)tableview;
@end
