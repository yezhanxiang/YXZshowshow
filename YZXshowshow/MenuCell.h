//
//  MenuCell.h
//  YZXshowshow
//
//  Created by 展祥叶 on 15/8/25.
//  Copyright (c) 2015年 yzx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuBtnInfo.h"

@interface MenuCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIButton *MenuButton;
@property (weak, nonatomic) IBOutlet UILabel *MenuLabel;

@property(strong,nonatomic)MenuBtnInfo *btnInfo;


@end
