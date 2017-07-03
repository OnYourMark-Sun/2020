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
    UIView *subView1 = alertView.view.subviews[0];
    UIView *subView2 = subView1.subviews[0];
    UIView *subView3 = subView2.subviews[0];
    UIView *subView4 = subView3.subviews[0];
    UIView *subView5 = subView4.subviews[0];
    
    //取title和message：
    UILabel *titleLabel = subView5.subviews[0];
    UILabel *messageLabel = subView5.subviews[1];
    messageLabel.textAlignment = NSTextAlignmentLeft;
    UIAlertAction *oneaction = [UIAlertAction actionWithTitle:oneAlertTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        oneActionfunc();
        
    }];
    [oneaction setValue:[UIColor colorWithHexString:@"00a560"] forKey:@"titleTextColor"];
    [alertView addAction:oneaction];
    
    UIAlertAction *twoaction = [UIAlertAction actionWithTitle:twoAlertTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        twoActionfunc();
        
    }];
    
    
    [twoaction setValue:[UIColor colorWithHexString:@"00a560"] forKey:@"titleTextColor"];
    [alertView addAction:twoaction];

    [target presentViewController:alertView animated:YES completion:nil];
}

+(void)pushAlertOneActionViewWithMessage:(NSString *)message Target:(UIViewController *)target Title:(NSString *)title oneAlertTitle:(NSString *)oneAlertTitle oneActionfunc:(actionFunc)oneActionfunc{
    
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *oneaction = [UIAlertAction actionWithTitle:oneAlertTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        oneActionfunc();
        
    }];
    [oneaction setValue:[UIColor colorWithHexString:@"00a560"] forKey:@"titleTextColor"];
    [alertView addAction:oneaction];
    [target presentViewController:alertView animated:YES completion:nil];
    
}
@end
