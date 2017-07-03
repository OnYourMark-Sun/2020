//
//  UIView+PopAlert.h
//  SouthDream
//
//  Created by zj on 16/10/9.
//  Copyright © 2016年 zj. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^actionFunc)(void);

@interface UIView (PopAlert)


+(void)pushAlertViewWithMessage:(NSString *)message Target:(UIViewController *)target Title:(NSString *)title AlertTitle:(NSString *)alertTitle ;
+(void)pushAlertTwoActionViewWithMessage:(NSString *)message Target:(UIViewController *)target Title:(NSString *)title oneAlertTitle:(NSString *)oneAlertTitle twoAlertTitle:(NSString *)twoAlertTitle  oneActionfunc:(actionFunc )oneActionfunc twoActionfunc:(actionFunc)twoActionfunc;

+(void)pushAlertOneActionViewWithMessage:(NSString *)message Target:(UIViewController *)target Title:(NSString *)title oneAlertTitle:(NSString *)oneAlertTitle   oneActionfunc:(actionFunc )oneActionfunc ;
@end
