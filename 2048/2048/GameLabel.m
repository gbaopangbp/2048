//
//  GameLabel.m
//  2048
//
//  Created by tirostiros on 14-12-23.
//  Copyright (c) 2014年 cn.com.tiros. All rights reserved.
//

#import "GameLabel.h"

@implementation GameLabel

-(id)initWithTitle:(NSInteger)value andPoint:(CGPoint)point
{
    self = [super init];
    if (self)
    {
        [self setFrame:CGRectMake(0, 0, 60, 60)];
        [self setTitle:value];
        [self setPoint:point];
    }
    return self;
}

-(UIFont*)getFontByValue:(NSInteger)value
{
    int size = 0;
    if (value < 10)
    {
        size = 30;
    }
    else if (size < 100)
    {
        size = 25;
    }
    else if (size < 1000)
    {
        size = 20;
    }
    else if(size < 10000)
    {
        size = 15;
    }
    else
    {
        size = 10;
    }
    
    return [UIFont systemFontOfSize:size];
}
-(UIColor*)getColorByValue:(NSInteger)value
{
    switch (value) {//这些颜色可以用mac自带的测色工具测
        case 0:
            return [UIColor colorWithRed:204.0/255.0 green:192.0/255.0 blue:180.0/255.0 alpha:1];
            break;
        case 2:
            return [UIColor colorWithRed:238.0/255.0 green:228.0/255.0 blue:218.0/255.0 alpha:1];
            break;
        case 4:
            return [UIColor colorWithRed:237.0/255.0 green:224.0/255.0 blue:201.0/255.0 alpha:1];
            break;
        case 8:
            return [UIColor colorWithRed:240.0/255.0 green:176.0/255.0 blue:125.0/255.0 alpha:1];
            break;
        case 16:
            return [UIColor colorWithRed:243.0/255.0 green:149.0/255.0 blue:104.0/255.0 alpha:1];
            break;
        case 32:
            return [UIColor colorWithRed:244.0/255.0 green:124.0/255.0 blue:99.0/255.0 alpha:1];
            break;
        case 64:
            return [UIColor colorWithRed:244.0/255.0 green:95.0/255.0 blue:67.0/255.0 alpha:1];
        case 128:
            return [UIColor purpleColor];
            break;
        case 256:
            return [UIColor blueColor];
            break;
        case 512:
            return [UIColor yellowColor];
            break;
        case 1024:
            return [UIColor orangeColor];
            break;
        case 2048:
            return [UIColor redColor];
            break;
        default:
            return [UIColor brownColor];
            break;
    }
    return nil;
}

-(void)setTitle:(NSInteger)value
{
    self.value = value;
    [self setText:[NSString stringWithFormat:@"%d",value]];
    [self setFont:[self getFontByValue:value]];
    [self setBackgroundColor:[self getColorByValue:value]];
    [self setTextAlignment:NSTextAlignmentCenter];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
