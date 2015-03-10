//
//  MoveDate.m
//  2048
//
//  Created by tirostiros on 15-2-28.
//  Copyright (c) 2015年 cn.com.tiros. All rights reserved.
//

#import "MoveDate.h"

@implementation MoveDate

-(id)initWithPoint:(CGPoint)point andPostion:(NSInteger)postion
{
    self = [super init];
    if (self)
    {
        [self setPoint:point];
        [self setToPostion:postion];
    }
    return self;
}

@end
