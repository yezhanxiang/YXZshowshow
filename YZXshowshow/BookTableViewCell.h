//
//  BookTableViewCell.h
//  YZXshowshow
//
//  Created by 展祥叶 on 15/9/13.
//  Copyright (c) 2015年 yzx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Book.h"

@interface BookTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *bookImage;
@property (weak, nonatomic) IBOutlet UILabel *bookTitle;
@property (weak, nonatomic) IBOutlet UILabel *bookUsername;
@property (weak, nonatomic) IBOutlet UILabel *bookText;
@property (weak, nonatomic) IBOutlet UILabel *bookDate;
@property (weak, nonatomic) IBOutlet UILabel *bookDay;
@property (weak, nonatomic) IBOutlet UILabel *count;

@property(strong,nonatomic)Book *book;



+(instancetype)initWithBookCell:(UITableView *)tableview;
@end
