//
//  GameData.h
//  2048
//
//  Created by tirostiros on 14-12-31.
//  Copyright (c) 2014年 cn.com.tiros. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GameData : NSObject

@property (nonatomic)NSNumber *score;
-(CGPoint)getFreePostion;
-(NSInteger)getRandomValueAtPostion:(CGPoint)point;

-(void)swip:(UISwipeGestureRecognizerDirection)direction;
-(NSArray*)getMoveArrayAfterSwipWithDir:(UISwipeGestureRecognizerDirection)dir;
-(NSArray*)getNumberArrayAfterSwip;
-(BOOL)shouldEndGame;
-(void)restartGame;



@end
