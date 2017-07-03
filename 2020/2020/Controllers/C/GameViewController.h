//
//  GameViewController.h
//  2020
//
//  Created by yurong on 2017/6/28.
//  Copyright © 2017年 yurong. All rights reserved.
//

#import "RootViewController.h"

@interface GameViewController : RootViewController

@property(nonatomic,assign) int numViewEmpty;//1空圈数
@property(nonatomic,assign) int numViewEmptytype;//空背景类型
@property(nonatomic,copy)NSString * GameNum;//游戏数量

@property(nonatomic,copy) NSString * challengeName;
@property(nonatomic,copy) NSString * GameRecord1;
@property(nonatomic,copy) NSString * GameRecord2;
@property(nonatomic,copy) NSString * GameRecord3;
@end
