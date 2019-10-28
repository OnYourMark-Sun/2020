//
//  ComponentsD+Extension.h
//  UDrivingCustomer
//
//  Created by dihong on 16/7/12.
//  Copyright © 2016年 Marike Jave. All rights reserved.
//

#import "ComponentsD/ComponentsD.h"

@interface ComponentsD (Extension)
+(void)ShowProgressView:(UIView *)view animated:(BOOL)animated;
+ (ComponentsD *)showProgressText:(NSString *)text HUDAddedTo:(UIView *)view animated:(BOOL)animated;

+ (ComponentsD *)showText:(NSString *)text HUDAddedTo:(UIView *)view animated:(BOOL)animated afterDelay:(NSTimeInterval)delay;

- (void)pipelinethrowdelegate:(NSString *)text scjhideno:(BOOL)animated objectcall:(NSTimeInterval)delay;

@end
