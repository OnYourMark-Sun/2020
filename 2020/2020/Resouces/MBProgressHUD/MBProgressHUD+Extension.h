//
//  MBProgressHUD+Extension.h
//  UDrivingCustomer
//
//  Created by dihong on 16/7/12.
//  Copyright © 2016年 Marike Jave. All rights reserved.
//

#import "MBProgressHUD/MBProgressHUD.h"

@interface MBProgressHUD (Extension)
+(void)ShowProgressView:(UIView *)view animated:(BOOL)animated;
+ (MBProgressHUD *)showProgressText:(NSString *)text HUDAddedTo:(UIView *)view animated:(BOOL)animated;

+ (MBProgressHUD *)showText:(NSString *)text HUDAddedTo:(UIView *)view animated:(BOOL)animated afterDelay:(NSTimeInterval)delay;

- (void)toText:(NSString *)text hide:(BOOL)animated afterDelay:(NSTimeInterval)delay;

@end
