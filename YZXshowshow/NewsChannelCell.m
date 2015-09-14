//
//  NewsChannelCell.m
//  YZXshowshow
//
//  Created by 展祥叶 on 15/8/31.
//  Copyright (c) 2015年 yzx. All rights reserved.
//

#import "NewsChannelCell.h"

@implementation NewsChannelCell

static NSString *channelCellID = @"channelCell";
+(instancetype)initNewsChannelCell:(UITableView *)tableview
{
    NewsChannelCell *cell = [tableview dequeueReusableCellWithIdentifier:channelCellID];
    if(!cell)
    {
        cell = [[NewsChannelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:channelCellID];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@",cell.channel.name];
    return cell;
}

@end
