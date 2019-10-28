//
//  UIView+PopAlert.m
//  SouthDream
//
//  Created by zj on 16/10/9.
//  Copyright © 2016年 zj. All rights reserved.
//

#import "UIView+PopAlert.h"

@implementation UIView (PopAlert)
+(void)pushAlertViewWithMessage:(NSString *)message Target:(UIViewController *)target Title:(NSString *)title AlertTitle:(NSString *)alertTitle{
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertView addAction:[UIAlertAction actionWithTitle:alertTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [target presentViewController:alertView animated:YES completion:nil];
}

+(void)pushAlertTwoActionViewWithMessage:(NSString *)message Target:(UIViewController *)target Title:(NSString *)title oneAlertTitle:(NSString *)oneAlertTitle twoAlertTitle:(NSString *)twoAlertTitle  oneActionfunc:(actionFunc )oneActionfunc twoActionfunc:(actionFunc)twoActionfunc{
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *oneaction = [UIAlertAction actionWithTitle:oneAlertTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        oneActionfunc();
        
    }];
    [alertView addAction:oneaction];
    
    UIAlertAction *twoaction = [UIAlertAction actionWithTitle:twoAlertTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        twoActionfunc();
        
    }];
    
    [alertView addAction:twoaction];

    [target presentViewController:alertView animated:YES completion:nil];
}

+(void)pushAlertOneActionViewWithMessage:(NSString *)message Target:(UIViewController *)target Title:(NSString *)title oneAlertTitle:(NSString *)oneAlertTitle oneActionfunc:(actionFunc)oneActionfunc{
    
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *oneaction = [UIAlertAction actionWithTitle:oneAlertTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        oneActionfunc();
        
    }];
    [alertView addAction:oneaction];
    [target presentViewController:alertView animated:YES completion:nil];
    
}
@end
