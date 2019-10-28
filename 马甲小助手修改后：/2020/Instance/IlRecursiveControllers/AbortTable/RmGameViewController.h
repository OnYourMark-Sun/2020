//
//  RmGameViewController.h
//  2020
//
//  Created by yurong on 2017/6/28.
//  Copyright © 2017年 yurong. All rights reserved.
//

#import "TlRootViewController.h"

@interface RmGameViewController : TlRootViewController

@property(nonatomic,assign) int operationEmpty;//1空圈数
@property(nonatomic,assign) int jmaNumViewEmptytype;//空背景类型
@property(nonatomic,copy)NSString * spaceTCPNum;//游戏数量

@property(nonatomic,copy) NSString * ueChallengeName;
@property(nonatomic,copy)NSString * mibChallengeRecord;
@property(nonatomic,copy) NSString * bydGameRecord1;
@property(nonatomic,copy)NSString * ojRecord1Name;

@end
