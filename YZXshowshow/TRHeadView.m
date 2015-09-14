//
//  TRHeadView.m
//  Day09-03-Weather-UI-V1
//
//  Created by Xiao on 15/6/11.
//  Copyright (c) 2015年 Xiao. All rights reserved.
//

#import "TRHeadView.h"

static CGFloat inset = 20;// 留边
static CGFloat temperatureHeight = 180;
static CGFloat hiloHeight = 40;
static CGFloat iconHeight = 30;
static CGFloat cityHeight = 40;
static CGFloat statusBarHeight = 20;

@implementation TRHeadView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id) initWithFrame:(CGRect)frame {
    
    if (self = [super initWithFrame:frame]) {
        //  创建各种Lable，加入header视图...
        //  计算各种Frame
        CGRect cityFrame = CGRectMake(0, statusBarHeight, frame.size.width, cityHeight);
        
        CGRect temperatureFrame = CGRectMake(inset, frame.size.height - (temperatureHeight + hiloHeight), frame.size.width - 2 * inset, temperatureHeight);
        
        CGRect hiloFrame = CGRectMake(inset, frame.size.height - hiloHeight, frame.size.width - 2*inset, hiloHeight);
        
        CGRect iconFrame = CGRectMake(inset, temperatureFrame.origin.y - iconHeight, iconHeight, iconHeight);
        
        CGRect conditionFrame = iconFrame;
        conditionFrame.size.width = frame.size.width - 2 * inset - iconHeight - 10;
        conditionFrame.origin.x = iconFrame.origin.x + iconHeight + 10;
        
        // 创建Label，并加入headerView
        
        //当前温度
        self.tempratureLabel = [[UILabel alloc] initWithFrame:temperatureFrame];
        self.tempratureLabel.backgroundColor = [UIColor clearColor];
        self.tempratureLabel.textColor = [UIColor whiteColor];
        self.tempratureLabel.font = [UIFont fontWithName:@"HelveticaNeue-UltraLight" size:120];
        //设置一个初始值
        self.tempratureLabel.text = @"0°";
        
        [self addSubview:self.tempratureLabel];
        
        //  最高/低温度
        self.hiloLabel = [[UILabel alloc] initWithFrame:hiloFrame];
        self.hiloLabel.backgroundColor = [UIColor clearColor];
        self.hiloLabel.textColor = [UIColor whiteColor];
        self.hiloLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:28];
        //设置初始值
        self.hiloLabel.text = @"0° / 0°";
        
        [self addSubview:self.hiloLabel];
        
        
        //  顶部城市名称
        UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Light" size:28];
        self.cityLabel = [[UILabel alloc] initWithFrame:cityFrame];
        self.cityLabel.backgroundColor = [UIColor clearColor];
        self.cityLabel.textColor = [UIColor whiteColor];
        //设置初始值
        self.cityLabel.text = @"Loading";
        self.cityLabel.font = font;
        self.cityLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:self.cityLabel];
        
        // 天气图标
        self.iconView = [[UIImageView alloc] initWithFrame:iconFrame];
        self.iconView.contentMode = UIViewContentModeScaleAspectFit;
        self.iconView.backgroundColor = [UIColor clearColor];
        //设置默认天气图标
        self.iconView.image = [UIImage imageNamed:@"weather-clear.png"];
        [self addSubview:self.iconView];
        
        //  天气情况描述
        self.conditionLabel = [[UILabel alloc] initWithFrame:conditionFrame];
        self.conditionLabel.backgroundColor = [UIColor clearColor];
        self.conditionLabel.font = font;
        self.conditionLabel.textColor = [UIColor whiteColor];
        //设置默认天气描述文本
        self.conditionLabel.text = @"Clear";
        
        [self addSubview:self.conditionLabel];
    }
    
    return self;
    
}

@end
