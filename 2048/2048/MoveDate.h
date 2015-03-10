//
//  MoveDate.h
//  2048
//
//  Created by tirostiros on 15-2-28.
//  Copyright (c) 2015年 cn.com.tiros. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MoveDate : NSObject
@property(nonatomic)CGPoint point;
@property(nonatomic)NSInteger toPostion;

-(id)initWithPoint:(CGPoint)point andPostion:(NSInteger)postion;

@end
