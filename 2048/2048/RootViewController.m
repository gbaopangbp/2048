//
//  RootViewController.m
//  2048
//
//  Created by tirostiros on 14-12-22.
//  Copyright (c) 2014年 cn.com.tiros. All rights reserved.
//

#import "RootViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "GameBackGroundView.h"
#import "GameData.h"
#import "MoveDate.h"

@interface RootViewController ()<GameBackGRoundSwipDelegate>
@property(nonatomic,strong)GameBackGroundView *backGroundView;
@property(nonatomic,strong)GameData *gameData;

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(GameData*)gameData
{
    if (!_gameData)
    {
        _gameData = [[GameData alloc] init];
    }
    return _gameData;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:0xFF/255.0 green:0xFF/255.0 blue:0xE0/255.0 alpha:1]];
//    UIButton *showButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 80, 70)];
//    [showButton setBackgroundColor:[UIColor colorWithRed:0xEE/255.0 green:0xFF/255.0 blue:0 alpha:1]];
//    [showButton setTitle:@"2048" forState:UIControlStateNormal];
//    [showButton setUserInteractionEnabled:NO];
//    [self.view addSubview:showButton];
    self.backGroundView = [[GameBackGroundView alloc] init];
    [self.backGroundView setDelegate:self];
    [self.view addSubview:self.backGroundView];
    CGPoint point = [self.gameData getFreePostion];
    NSInteger value = [self.gameData getRandomValueAtPostion:point];
    GameLabel *label = [[GameLabel alloc] initWithTitle:value andPoint:point];
    [self.backGroundView addLabel:label atPoint:point];
    
//    CGPoint secPoint = [self.gameData getFreePostion];
//    NSInteger secValue = [self.gameData getRandomValueAtPostion:secPoint];
//    GameLabel *secLabel = [[GameLabel alloc] initWithTitle:secValue andPoint:point];
//    [self.backGroundView addLabel:secLabel atPoint:secPoint];
    




    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark --覆盖状态栏函数
//ios7开始状态栏有controller控制，全局的函数不再其作用
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleBlackTranslucent;
}
-(BOOL)prefersStatusBarHidden
{
    return NO;
}

#pragma mark 手势代理
-(void)siwp:(UISwipeGestureRecognizerDirection)direction
{
    [self.gameData swip:direction];
    NSArray *swipData = [self.gameData getMoveArrayAfterSwipWithDir:direction];

    if (swipData)
    {
        
        [UIView beginAnimations:@"swipAni" context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationDelegate:self];
        
        [self.backGroundView swipLabelWithData:swipData];
        [UIView commitAnimations];
    }
    else
    {
        BOOL gameEnd = [self.gameData shouldEndGame];
        if (gameEnd)
        {
            NSString *message = [NSString stringWithFormat:@"您的最后得分为%@，加油！",[self.gameData score]];
            [[[UIAlertView alloc] initWithTitle:@"游戏结束" message:message delegate:self cancelButtonTitle:@"重试" otherButtonTitles:@"haode", nil] show];
            
            NSUserDefaults *save = [NSUserDefaults standardUserDefaults];
            NSInteger high = [save integerForKey:@"HistoryHighScore"];
            if (high < [self.gameData.score intValue])
            {
                [save setInteger:[self.gameData.score intValue] forKey:@"HistoryHighScore"];

            }
        }
    }
 


    
    
}

#pragma mark uiview动画代理
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    NSArray *numberData = [self.gameData getNumberArrayAfterSwip];
    [self.backGroundView setNowScore:[self.gameData.score intValue]];

    [UIView animateWithDuration:0.2 animations:^(void){
        [self.backGroundView resetNumberWithData:numberData];

    } completion:^(BOOL complete){
        CGPoint point = [self.gameData getFreePostion];
        NSInteger value = [self.gameData getRandomValueAtPostion:point];
        GameLabel *label = [[GameLabel alloc] initWithTitle:value andPoint:point];
        [self.backGroundView addLabel:label atPoint:point];

    }];
    
    
    
}

#pragma mark uialertview代理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.gameData restartGame];
    [self.backGroundView restartGame];
    
    CGPoint point = [self.gameData getFreePostion];
    NSInteger value = [self.gameData getRandomValueAtPostion:point];
    GameLabel *label = [[GameLabel alloc] initWithTitle:value andPoint:point];
    [self.backGroundView addLabel:label atPoint:point];
    
}



@end
