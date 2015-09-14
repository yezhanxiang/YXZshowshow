//
//  UIView+ScaleButton.m
//  YZXshowshow
//
//  Created by 展祥叶 on 15/8/26.
//  Copyright (c) 2015年 yzx. All rights reserved.
//

#import "UIView+ScaleButton.h"

@implementation UIView (ScaleButton)
-(void)startToScale:(NSTimeInterval)duration
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.5, 0.5, 1.0)];
    animation.duration = duration;
    // 动画终了后不返回初始状态
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    //是否执行逆动画
    //animation.autoreverses = YES;
    
    [self.layer addAnimation:animation forKey:@"transform"];
}

-(void)stopToScale:(NSTimeInterval)duration
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)];
    animation.duration = duration;
    // 动画终了后不返回初始状态
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    
    [self.layer addAnimation:animation forKey:@"transform"];
}


@end
