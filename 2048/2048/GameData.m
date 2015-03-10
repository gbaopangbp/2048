//
//  GameData.m
//  2048
//
//  Created by tirostiros on 14-12-31.
//  Copyright (c) 2014年 cn.com.tiros. All rights reserved.
//

#import "GameData.h"
#import "MoveDate.h"
@interface GameData()
{
    int data[4][4];
    int labelNum;
    int movePostion[4][4];
}

@end


@implementation GameData

-(CGPoint)getFreePostion
{
    int x = 0;
    int y = 0;
    if (labelNum < 16)
    {
        int random = arc4random()%(16 - labelNum) + 1;
        for (int i = 0; i < 4; i++)
        {
            for (int j = 0; j < 4; j++)
            {
                if (0 == data[i][j])
                {
                random--;
                if (0 == random)
                {
                    x = i;
                    y = j;
                    break;

                }
                }
            }
        }
    }

    return CGPointMake(x, y);
}

//获取一个新的随机数，如果已经存在，返回0错误
-(NSInteger)getRandomValueAtPostion:(CGPoint)point;
{
    int value = 0;
    int x = point.x;
    int y = point.y;
    if (0 == data[x][y])
    {
        int random = arc4random()%3;
        if (2 == random)
        {
            value = 4;
        }
        else
        {
            value = 2;
        }
        labelNum++;
    }
    data[x][y] = value;
    return value;
}

//0表示原来这个位置有数字，－1，表示没有，其他数字表示要移到的位置
-(void)resetData
{
    for (int i = 0; i < 4; i++)
    {
        for (int j = 0; j < 4; j++)
        {
            if (0 != data[i][j])
            {
                movePostion[i][j] = 0;
            }
            else
            {
                movePostion[i][j] = -1;
            }
        }
    }
}
-(void)swipLeft
{
    for (int j = 0; j < 4; j++)
    {
        int first = -1;
        int move = 0;
        int firstPostion = 0;
        BOOL haveSame = NO;
        for (int i = 0; i < 4; i++)
        {
            if (0 != data[i][j])
            {
                if (-1 == first)
                {
                    first = data[i][j];
                    firstPostion = j*4 + i + 1 - move;
                    if (move > 0)
                    {
                        data[i - move][j] = data[i][j];
                        data[i][j] = 0;
                        movePostion[i][j] = firstPostion;
                    }
                }
                else
                {
                    if (first == data[i][j] && !haveSame)
                    {
                        movePostion[i][j] = firstPostion;
                        move++;
                        first = -1;
                        data[(firstPostion - 1)%4][j] = data[i][j]*2;
                        data[i][j] = 0;
                        labelNum--;
                        self.score = [NSNumber numberWithInt: [self.score intValue] + data[(firstPostion - 1)%4][j]];
                        haveSame = YES;
                    }
                    else
                    {
                        first = data[i][j];
                        firstPostion = j*4 + i + 1 - move;
                        if (move > 0)
                        {
                            data[i - move][j] = data[i][j];
                            data[i][j] = 0;
                            movePostion[i][j] = firstPostion;
                        }
                        
                    }
                }
            }
            else
            {
                //没有数字，需要移动加1
                move++;
            }
            
        }
    }
    
}

-(void)swipRight
{
    for (int j = 0; j < 4; j++)
    {
        int first = -1;
        int move = 0;
        int firstPostion = 0;
        BOOL haveSame = NO;

        for (int i = 4 - 1; i >= 0; i--)
        {
            if (0 != data[i][j])
            {
                if (-1 == first)
                {
                    first = data[i][j];
                    firstPostion = j*4 + i + 1 + move;
                    if (move > 0)
                    {
                        data[i + move][j] = data[i][j];
                        data[i][j] = 0;
                        movePostion[i][j] = firstPostion;
                    }
                }
                else
                {
                    if (first == data[i][j] && !haveSame)
                    {
                        movePostion[i][j] = firstPostion;
                        move++;
                        first = -1;
                        data[(firstPostion - 1)%4][j] = data[i][j]*2;
                        data[i][j] = 0;
                        labelNum--;
                        self.score = [NSNumber numberWithInt: [self.score intValue] + data[(firstPostion - 1)%4][j]];
                        haveSame = YES;

                    }
                    else
                    {
                        first = data[i][j];
                        firstPostion = j*4 + i + 1 + move;
                        if (move > 0)
                        {
                            data[i + move][j] = data[i][j];
                            data[i][j] = 0;
                            movePostion[i][j] = firstPostion;
                        }
                    }
                }
            }
            else
            {
                //没有数字，需要移动加1
                move++;
            }
            
        }
    }
    
}

-(void)swipUp
{
    for (int i = 0; i < 4; i++)
    {
        int first = -1;
        int move = 0;
        int firstPostion = 0;
        BOOL haveSame = NO;

        for (int j = 0; j < 4; j++)
        {
            if (0 != data[i][j])
            {
                if (-1 == first)
                {
                    first = data[i][j];
                    firstPostion = j*4 + i + 1 - move*4;
                    if (move > 0)
                    {
                        data[i][j - move] = data[i][j];
                        data[i][j] = 0;
                        movePostion[i][j] = firstPostion;
                    }

                }
                else
                {
                    if (first == data[i][j] && !haveSame)
                    {
                        movePostion[i][j] = firstPostion;
                        move++;
                        first = -1;
                        data[i][(firstPostion - 1)/4] = data[i][j]*2;
                        data[i][j] = 0;
                        labelNum--;
                        self.score = [NSNumber numberWithInt: [self.score intValue] + data[i][(firstPostion - 1)/4]];
                        haveSame = YES;
                    }
                    else
                    {
                        first = data[i][j];
                        firstPostion = j*4 + i + 1 - move*4;
                        if (move > 0)
                        {
                            data[i][j - move] = data[i][j];
                            data[i][j] = 0;
                            movePostion[i][j] = firstPostion;
                        }
                        
                    }
                }
            }
            else
            {
                //没有数字，需要移动加1
                move++;
            }
            
        }
    }
    
}

-(void)swipDown
{
    for (int i = 0; i < 4; i++)
    {
        int first = -1;
        int move = 0;
        int firstPostion = 0;
        BOOL haveSame = NO;

        for (int j = 4 - 1; j >= 0; j--)
        {
            if (0 != data[i][j])
            {
                if (-1 == first)
                {
                    first = data[i][j];
                    firstPostion = j*4 + i + 1 + move*4;
                    if (move > 0)
                    {
                        data[i][j + move] = data[i][j];
                        data[i][j] = 0;
                        movePostion[i][j] = firstPostion;
                    }
                }
                else
                {
                    if (first == data[i][j] && !haveSame)
                    {
                        movePostion[i][j] = firstPostion;
                        move++;
                        first = -1;
                        data[i][(firstPostion - 1)/4] = data[i][j]*2;
                        data[i][j] = 0;
                        labelNum--;
                        self.score = [NSNumber numberWithInt: [self.score intValue] + data[i][(firstPostion - 1)/4]];
                        haveSame = YES;
                    }
                    else
                    {
                        first = data[i][j];
                        firstPostion = j*4 + i + 1 + move*4;
                        if (move > 0)
                        {
                            movePostion[i][j] = j*4 + i + 1 + move*4;
                            data[i][j + move] = data[i][j];
                            data[i][j] = 0;
                        }
                        
                    }
                }
            }
            else
            {
                //没有数字，需要移动加1
                move++;
            }
            
        }
    }
    
}

-(void)swip:(UISwipeGestureRecognizerDirection)direction
{
    [self resetData];
    switch (direction) {
        case UISwipeGestureRecognizerDirectionLeft:
            [self swipLeft];
            break;
        case UISwipeGestureRecognizerDirectionRight:
            [self swipRight];
            break;
        case UISwipeGestureRecognizerDirectionUp:
            [self swipUp];
            break;
        case UISwipeGestureRecognizerDirectionDown:
            [self swipDown];
            break;
        default:
            break;
    }
}

-(NSArray*)getMoveArrayAfterSwipWithDir:(UISwipeGestureRecognizerDirection)dir
{
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    BOOL haveMove = NO;
    switch (dir) {
        case UISwipeGestureRecognizerDirectionLeft:
        case UISwipeGestureRecognizerDirectionUp:
            for (int i = 0; i < 4; i++)
            {
                for (int j = 0; j < 4; j++)
                {
                    if (-1 != movePostion[i][j] && 0 != movePostion[i][j])
                    {
                        haveMove = YES;
                        CGPoint point = CGPointMake(i, j);
                        MoveDate *data = [[MoveDate alloc] initWithPoint:point andPostion:movePostion[i][j]];
                        [dataArray addObject:data];
                    }
                }
            }
            break;
            case UISwipeGestureRecognizerDirectionDown:
            case UISwipeGestureRecognizerDirectionRight:
            for (int i = 4-1; i >= 0; i--)
            {
                for (int j = 4 - 1; j >= 0; j--)
                {
                    if (-1 != movePostion[i][j] && 0 != movePostion[i][j])
                    {
                        haveMove = YES;
                        CGPoint point = CGPointMake(i, j);
                        MoveDate *data = [[MoveDate alloc] initWithPoint:point andPostion:movePostion[i][j]];
                        [dataArray addObject:data];
                    }
                }
            }
            break;
            
        default:
            break;
    }
 
    if (!haveMove)
    {
        dataArray = nil;
    }
    return dataArray;
}

-(NSArray*)getNumberArrayAfterSwip
{
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 4; i++)
    {
        for (int j = 0; j < 4; j++)
        {
            if (0 != data[i][j])
            {
                CGPoint point = CGPointMake(i, j);
                MoveDate *Mocwdata = [[MoveDate alloc] initWithPoint:point andPostion:data[i][j]];
                [dataArray addObject:Mocwdata];
            }
        }
    }
    return dataArray;
}

-(BOOL)shouldEndGame
{
    for (int i = 0; i < 4; i++)
    {
        for (int j = 0; j < 4 - 1; j++)
        {
            if (data[i][j] == data[i][j+1])
            {
                return NO;
            }
        }
    }
    
    for (int j = 0; j < 4; j++)
    {
        for (int i = 0; i < 4 - 1; i++)
        {
            if (data[i][j] == data[i+1][j])
            {
                return NO;
            }
        }
    }
    return YES;
}

-(void)restartGame
{
    for (int i = 0; i < 4; i++)
    {
        for (int j = 0; j < 4; j++)
        {
            data[i][j] = 0;
            movePostion[i][j] = -1;
        }
    }
    labelNum = 0;
}


@end
