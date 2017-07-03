//
//  MBProgressHUD+Extension.m
//  UDrivingCustomer
//
//  Created by dihong on 16/7/12.
//  Copyright © 2016年 Marike Jave. All rights reserved.
//

#import "MBProgressHUD+Extension.h"

@implementation MBProgressHUD (Extension)

+ (MBProgressHUD *)showProgressText:(NSString *)text HUDAddedTo:(UIView *)view animated:(BOOL)animated;{
    [MBProgressHUD hideAllHUDsForView:view animated:NO];
    
    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    //状态栏frame
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    
    progressHUD.frame = CGRectMake(0, rectStatus.size.height+IPHONEHIGHT(88),ScreenWidth , ScreenHeight-rectStatus.size.height-IPHONEHIGHT(88));
    progressHUD.removeFromSuperViewOnHide = YES;
    progressHUD.label.text = text;
  
    progressHUD.label.font = [UIFont systemFontOfSize:IPHONEWIDTH(35)];
    CGSize labelSize = [text sizeWithFont:[UIFont systemFontOfSize:IPHONEWIDTH(35)] constrainedToSize:CGSizeMake(ScreenWidth-IPHONEWIDTH(56), MAXFLOAT)];
    progressHUD.label.size = CGSizeMake(labelSize.width, labelSize.height);
    progressHUD.label.textAlignment = NSTextAlignmentLeft;
    progressHUD.label.numberOfLines = 0;
    
    return progressHUD;
}

+ (MBProgressHUD *)showText:(NSString *)text HUDAddedTo:(UIView *)view animated:(BOOL)animated afterDelay:(NSTimeInterval)delay;{
    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    //状态栏frame
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    
    progressHUD.frame = CGRectMake(0, rectStatus.size.height+IPHONEHIGHT(88),ScreenWidth , ScreenHeight-rectStatus.size.height-IPHONEHIGHT(88));
    [progressHUD toText:text hide:animated afterDelay:delay];
    
    
    progressHUD.label.font = [UIFont systemFontOfSize:IPHONEWIDTH(35)];
    CGSize labelSize = [text sizeWithFont:[UIFont systemFontOfSize:IPHONEWIDTH(35)] constrainedToSize:CGSizeMake(ScreenWidth-IPHONEWIDTH(56), MAXFLOAT)];
    progressHUD.label.size = CGSizeMake(labelSize.width, labelSize.height);
    progressHUD.label.textAlignment = NSTextAlignmentLeft;
    progressHUD.label.numberOfLines = 0;
    return progressHUD;
}

- (void)toText:(NSString *)text hide:(BOOL)animated afterDelay:(NSTimeInterval)delay;{
    self.removeFromSuperViewOnHide = YES;
    self.mode = MBProgressHUDModeText;
    self.label.text = text;
    
    [self hideAnimated:animated afterDelay:delay];
    
    self.label.font = [UIFont systemFontOfSize:IPHONEWIDTH(35)];
    CGSize labelSize = [text sizeWithFont:[UIFont systemFontOfSize:IPHONEWIDTH(35)] constrainedToSize:CGSizeMake(ScreenWidth-IPHONEWIDTH(56), MAXFLOAT)];
    self.label.size = CGSizeMake(labelSize.width, labelSize.height);
    self.label.textAlignment = NSTextAlignmentLeft;
    self.label.numberOfLines = 0;
}

+(void)ShowProgressView:(UIView *)view animated:(BOOL)animated{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:animated];
    //状态栏frame
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    
    hud.frame = CGRectMake(0, 20+IPHONEHIGHT(88),ScreenWidth , ScreenHeight-20-IPHONEHIGHT(88));
    
}
@end
