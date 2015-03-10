//
//  GameBackGroundView.h
//  2048
//
//  Created by tirostiros on 14-12-23.
//  Copyright (c) 2014年 cn.com.tiros. All rights reserved.
//  北京的所有view

#import <UIKit/UIKit.h>
#import "GameLabel.h"

@protocol GameBackGRoundSwipDelegate <NSObject>
-(void)siwp:(UISwipeGestureRecognizerDirection)direction;
@end

@interface GameBackGroundView : UIView
@property(nonatomic,strong)UIButton *menuButton;
@property(nonatomic,strong)UIButton *listButton;

@property(nonatomic,strong)UILabel *scoreLabel;
@property(nonatomic,strong)UILabel *historyLabel;
@property(nonatomic)id<GameBackGRoundSwipDelegate>delegate;


//设置当前分数
-(void)setNowScore:(NSInteger)score;
//设置历史最高分
-(void)setHistoryScore:(NSInteger)score;

-(void)addLabel:(GameLabel*)label atPoint:(CGPoint)point;
-(void)swipLabelWithData:(NSArray *)array;
-(void)resetNumberWithData:(NSArray *)array;
-(void)restartGame;



@end

