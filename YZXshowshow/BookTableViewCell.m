//
//  BookTableViewCell.m
//  YZXshowshow
//
//  Created by 展祥叶 on 15/9/13.
//  Copyright (c) 2015年 yzx. All rights reserved.
//

#import "BookTableViewCell.h"
#import <sdwebimage/UIImageView+WebCache.h>

@implementation BookTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

static NSString *cellID = @"BookCell";
+(instancetype)initWithBookCell:(UITableView *)tableview
{
    BookTableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:cellID];
    if(!cell)
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"BookTableViewCell" owner:nil options:nil]firstObject];
    }
    
    return cell;
}

-(void)setBook:(Book *)book
{
    _book = book;
    self.bookTitle.text = book.title;
    self.bookUsername.text = book.userName;
    self.bookText.text = book.text;
    self.bookDate.text = book.startTime;
    self.bookDay.text = [NSString stringWithFormat:@"%ld",(long)book.routeDays];
    self.count.text = [NSString stringWithFormat:@"%ld",(long)book.viewCount];
    NSURL *imageURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@",book.headImage]];
    [self.bookImage sd_setImageWithURL:imageURL placeholderImage:[UIImage imageNamed:@"bookImg.png"]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
