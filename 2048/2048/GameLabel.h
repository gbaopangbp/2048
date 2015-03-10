//
//  GameLabel.h
//  2048
//
//  Created by tirostiros on 14-12-23.
//  Copyright (c) 2014年 cn.com.tiros. All rights reserved.
//  游戏数字的一个view

#import <UIKit/UIKit.h>

@interface GameLabel : UILabel
@property(nonatomic)NSInteger value;
@property(nonatomic)CGPoint point;

-(id)initWithTitle:(NSInteger)value andPoint:(CGPoint)point;
-(void)setTitle:(NSInteger)value;

@end
