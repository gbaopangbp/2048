//
//  GameBackGroundView.m
//  2048
//
//  Created by tirostiros on 14-12-23.
//  Copyright (c) 2014年 cn.com.tiros. All rights reserved.
//

#import "GameBackGroundView.h"
#import "MoveDate.h"

@interface GameBackGroundView ()
@property(nonatomic,strong)NSMutableDictionary *gameLabeldic;

@end

@implementation GameBackGroundView

-(NSMutableDictionary *)gameLabeldic
{
    if (!_gameLabeldic)
    {
        _gameLabeldic = [[NSMutableDictionary alloc] init];
    }
    return _gameLabeldic;
}

-(void)setup
{
    UILabel *showLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 85, 80)];
    [showLabel setText:@"2048"];
    [showLabel setBackgroundColor:[UIColor colorWithRed:0xCD/255.0 green:0xCD/255.0 blue:0 alpha:1]];
    [showLabel setTextAlignment:NSTextAlignmentCenter];
    [showLabel setTextColor:[UIColor whiteColor]];
    [showLabel setFont:[UIFont systemFontOfSize:30]];
    showLabel.layer.cornerRadius = 5;
    showLabel.layer.masksToBounds = YES;
    [self addSubview:showLabel];
    
    
    _scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 20, 80, 40)];
    [_scoreLabel setBackgroundColor:[UIColor grayColor]];
    [_scoreLabel setFont:[UIFont systemFontOfSize:15]];
    [_scoreLabel setNumberOfLines:2];
    [_scoreLabel setTextAlignment:NSTextAlignmentCenter];
    [_scoreLabel setText:@"分数:\n0"];
    _scoreLabel.layer.cornerRadius = 4;
    _scoreLabel.layer.masksToBounds = YES;
    
    
    [self addSubview:_scoreLabel];
    
    _menuButton = [[UIButton alloc] initWithFrame:CGRectMake(120, 70, 80, 30)];
    [_menuButton setBackgroundColor:[UIColor colorWithRed:0xE0/255.0 green:0x45/255.0 blue:0 alpha:1]];
    [_menuButton setTitle:@"菜单" forState:UIControlStateNormal];
    _menuButton.titleLabel.font = [UIFont systemFontOfSize:10];
    _menuButton.layer.cornerRadius = 4;
    _menuButton.layer.masksToBounds = YES;
    [self addSubview:_menuButton];
    
    _historyLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 20, 80, 40)];
    [_historyLabel setBackgroundColor:[UIColor grayColor]];
    [_historyLabel setFont:[UIFont systemFontOfSize:10]];
    [_historyLabel setNumberOfLines:2];
    [_historyLabel setTextAlignment:NSTextAlignmentCenter];
    NSUserDefaults *save = [NSUserDefaults standardUserDefaults];
    NSInteger high = [save integerForKey:@"HistoryHighScore"];
    NSString *history = [NSString stringWithFormat:@"历史最高分数:\n%d",high];
    [_historyLabel setText:history];
    _historyLabel.layer.cornerRadius = 4;
    _historyLabel.layer.masksToBounds = YES;
    [self addSubview:_historyLabel];
    
    _listButton = [[UIButton alloc] initWithFrame:CGRectMake(220, 70, 80, 30)];
    [_listButton setBackgroundColor:[UIColor colorWithRed:0xE0/255.0 green:0x45/255.0 blue:0 alpha:1]];
    [_listButton setTitle:@"排行榜" forState:UIControlStateNormal];
    _listButton.titleLabel.font = [UIFont systemFontOfSize:10];
    _listButton.layer.cornerRadius = 4;
    _listButton.layer.masksToBounds = YES;
    [self addSubview:_listButton];
    
    UIView *background = [[UIView alloc] initWithFrame:CGRectMake(20, 140, 280, 280)];
    [background setBackgroundColor:[UIColor grayColor]];
    background.layer.cornerRadius = 5;
    background.layer.masksToBounds = YES;
    [self addSubview:background];
    
    for (int i = 0; i < 4; i++)
    {
        for (int j = 0; j < 4; j++)
        {
            UIView *small = [[UIView alloc] initWithFrame:CGRectMake(20 + 8 * (i+1) + 60*i, 140 + 8 *(j+1) + 60*j, 60, 60)];
            [small setBackgroundColor:[UIColor colorWithRed:0x8B/255.0 green:0x8B/255.0 blue:0x7A/255.0 alpha:1]];
            [self addSubview:small];
        }
    }
    for (int dir = 0; dir < 4; dir++)
    {
        UISwipeGestureRecognizer *swip = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
        [self setUserInteractionEnabled:YES];
        [swip setDirection:1<<dir];
        [self addGestureRecognizer:swip];

    }


}

-(void)addLabel:(GameLabel*)label atPoint:(CGPoint)point;
{
    int i = point.x;
    int j = point.y;
    CGPoint center = CGPointMake(20 + 8 * (i+1) + 60*i + 60/2, 140 + 8 *(j+1) + 60*j + 60 /2);
    [label setCenter:center];
    [self addSubview:label];
    [self.gameLabeldic setObject:label forKey:[NSNumber numberWithInt:label.point.y*4+label.point.x]];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        [self setup];
    }
    return self;
}

-(id)init
{
    self = [super init];
    if (self)
    {
        [self setFrame:[UIScreen mainScreen].bounds];
        [self setup];
    }
    return self;
}

-(void)setNowScore:(NSInteger)score
{
    [_scoreLabel setText:[NSString stringWithFormat:@"分数:\n%d",score]];
}

-(void)setHistoryScore:(NSInteger)score
{
    [_historyLabel setText:[NSString stringWithFormat:@"历史最高分数:\n%d",score]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)handleGesture:(UISwipeGestureRecognizer*)gestureRecognizer;
{
    
//    if ([self.delegate respondsToSelector:@selector(swip:)])
    {
        [self.delegate siwp:[gestureRecognizer direction]];
    }
}

-(void)swipLabelWithData:(NSArray *)array;
{
    int lastPos = 0;
    for (MoveDate *data in array)
    {
        GameLabel *label = [self.gameLabeldic objectForKey:[NSNumber numberWithInt:data.point.y*4+data.point.x]];
        

//        if (data.toPostion != lastPos)
        {
            int i = (data.toPostion - 1 )%4;
            int j = (data.toPostion - 1)/4;
            [label setFrame:CGRectMake(20 + 8 * (i+1) + 60*i, 140 + 8 *(j+1) + 60*j,60,60)];
            //从字典中将旧的label移除，
            [self.gameLabeldic removeObjectForKey:[NSNumber numberWithInt:data.point.y*4 + data.point.x]];
            GameLabel *removeLabel = [self.gameLabeldic objectForKey:[NSNumber numberWithInt:data.toPostion - 1]];
            if (removeLabel)
            {
                [removeLabel removeFromSuperview];
            }

            [self.gameLabeldic setObject:label forKey:[NSNumber numberWithInt:data.toPostion - 1]];
        }
//        else
        {
//            [label removeFromSuperview];
        }
        lastPos = data.toPostion;
    }
    
    NSLog(@"labeldic:%@",self.gameLabeldic);

    
}

-(void)resetNumberWithData:(NSArray *)array
{
    for (MoveDate *data in array)
    {
        GameLabel *label = [self.gameLabeldic objectForKey:[NSNumber numberWithInt:data.point.y*4+data.point.x]];
        
        if (label)
        {
            [label setTitle:data.toPostion];
        }
        else
        {
        }
    }
 
}

-(void)restartGame
{
    for (int i = 1; i <= 16; i++)
    {
        GameLabel *label = [self.gameLabeldic objectForKeyedSubscript:[NSNumber numberWithInt:i]];
        if (label)
        {
            [label removeFromSuperview];
        }
    }
    [self.gameLabeldic removeAllObjects];
    [self setNowScore:0];
}



@end
