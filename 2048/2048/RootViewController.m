//
//  RootViewController.m
//  2048
//
//  Created by tirostiros on 14-12-22.
//  Copyright (c) 2014年 cn.com.tiros. All rights reserved.
//

#import "RootViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface RootViewController ()

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor colorWithRed:0xFF/255.0 green:0xFF/255.0 blue:0xE0/255.0 alpha:1]];
//    UIButton *showButton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 80, 70)];
//    [showButton setBackgroundColor:[UIColor colorWithRed:0xEE/255.0 green:0xFF/255.0 blue:0 alpha:1]];
//    [showButton setTitle:@"2048" forState:UIControlStateNormal];
//    [showButton setUserInteractionEnabled:NO];
//    [self.view addSubview:showButton];
    
    UILabel *showLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 85, 80)];
    [showLabel setText:@"2048"];
    [showLabel setBackgroundColor:[UIColor colorWithRed:0xCD/255.0 green:0xCD/255.0 blue:0 alpha:1]];
    [showLabel setTextAlignment:NSTextAlignmentCenter];
    [showLabel setTextColor:[UIColor whiteColor]];
    [showLabel setFont:[UIFont systemFontOfSize:30]];
    showLabel.layer.cornerRadius = 5;
    showLabel.layer.masksToBounds = YES;
    [self.view addSubview:showLabel];
    
    
    UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 20, 80, 40)];
    [scoreLabel setBackgroundColor:[UIColor grayColor]];
    [scoreLabel setFont:[UIFont systemFontOfSize:15]];
    [scoreLabel setNumberOfLines:2];
    [scoreLabel setTextAlignment:NSTextAlignmentCenter];
    [scoreLabel setText:@"分数:\n0"];
    scoreLabel.layer.cornerRadius = 4;
    scoreLabel.layer.masksToBounds = YES;
    [self.view addSubview:scoreLabel];
    
    UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(120, 70, 80, 30)];
    [menuButton setBackgroundColor:[UIColor colorWithRed:0xE0/255.0 green:0x45/255.0 blue:0 alpha:1]];
    [menuButton setTitle:@"菜单" forState:UIControlStateNormal];
    menuButton.titleLabel.font = [UIFont systemFontOfSize:10];
    menuButton.layer.cornerRadius = 4;
    menuButton.layer.masksToBounds = YES;
    [self.view addSubview:menuButton];
    
    UILabel *historyLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 20, 80, 40)];
    [historyLabel setBackgroundColor:[UIColor grayColor]];
    [historyLabel setFont:[UIFont systemFontOfSize:10]];
    [historyLabel setNumberOfLines:2];
    [historyLabel setTextAlignment:NSTextAlignmentCenter];
    [historyLabel setText:@"历史最高分数:\n0"];
    historyLabel.layer.cornerRadius = 4;
    historyLabel.layer.masksToBounds = YES;
    [self.view addSubview:historyLabel];
    
    UIButton *listButton = [[UIButton alloc] initWithFrame:CGRectMake(220, 70, 80, 30)];
    [listButton setBackgroundColor:[UIColor colorWithRed:0xE0/255.0 green:0x45/255.0 blue:0 alpha:1]];
    [listButton setTitle:@"排行榜" forState:UIControlStateNormal];
    listButton.titleLabel.font = [UIFont systemFontOfSize:10];
    listButton.layer.cornerRadius = 4;
    listButton.layer.masksToBounds = YES;
    [self.view addSubview:listButton];
    
    UIView *background = [[UIView alloc] initWithFrame:CGRectMake(20, 140, 280, 280)];
    [background setBackgroundColor:[UIColor grayColor]];
    background.layer.cornerRadius = 5;
    background.layer.masksToBounds = YES;
    [self.view addSubview:background];
    
    for (int i = 0; i < 4; i++)
    {
        for (int j = 0; j < 4; j++)
        {
            UIView *small = [[UIView alloc] initWithFrame:CGRectMake(20 + 8 * (i+1) + 60*i, 140 + 8 *(j+1) + 60*j, 60, 60)];
            [small setBackgroundColor:[UIColor colorWithRed:0x8B/255.0 green:0x8B/255.0 blue:0x7A/255.0 alpha:1]];
            [self.view addSubview:small];
        }
    }
    


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

@end
