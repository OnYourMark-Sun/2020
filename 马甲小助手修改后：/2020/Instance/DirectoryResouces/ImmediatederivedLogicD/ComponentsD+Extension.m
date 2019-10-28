//
//  ComponentsD+Extension.m
//  UDrivingCustomer
//
//  Created by dihong on 16/7/12.
//  Copyright © 2016年 Marike Jave. All rights reserved.
//

#import "ComponentsD+Extension.h"

@implementation ComponentsD (Extension)

+ (ComponentsD *)showProgressText:(NSString *)text HUDAddedTo:(UIView *)view animated:(BOOL)animated;{
    [ComponentsD hideAllHUDsForView:view animated:NO];
    
    ComponentsD *progressHUD = [ComponentsD defaultCalendricalbug:view gwkanimatedbd:YES];
    //状态栏frame
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    
    progressHUD.frame = CGRectMake(0, rectStatus.size.height+IPHONEHIGHT(88),ScreenWidth , ScreenHeight-rectStatus.size.height-IPHONEHIGHT(88));
    progressHUD.callbackRobustnessHide = YES;
    progressHUD.label.text = text;
  
    progressHUD.label.font = [UIFont systemFontOfSize:IPHONEWIDTH(35)];
    CGSize labelSize = [text sizeWithFont:[UIFont systemFontOfSize:IPHONEWIDTH(35)] constrainedToSize:CGSizeMake(ScreenWidth-IPHONEWIDTH(56), MAXFLOAT)];
    progressHUD.label.size = CGSizeMake(labelSize.width, labelSize.height);
    progressHUD.label.textAlignment = NSTextAlignmentLeft;
    progressHUD.label.numberOfLines = 0;
    
    return progressHUD;
}

+ (ComponentsD *)showText:(NSString *)text HUDAddedTo:(UIView *)view animated:(BOOL)animated afterDelay:(NSTimeInterval)delay;{
    ComponentsD *progressHUD = [ComponentsD defaultCalendricalbug:view gwkanimatedbd:YES];
    //状态栏frame
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    
    progressHUD.frame = CGRectMake(0, rectStatus.size.height+IPHONEHIGHT(88),ScreenWidth , ScreenHeight-rectStatus.size.height-IPHONEHIGHT(88));
    [progressHUD pipelinethrowdelegate:text scjhideno:animated objectcall:delay];
    
    
    progressHUD.label.font = [UIFont systemFontOfSize:IPHONEWIDTH(35)];
    CGSize labelSize = [text sizeWithFont:[UIFont systemFontOfSize:IPHONEWIDTH(35)] constrainedToSize:CGSizeMake(ScreenWidth-IPHONEWIDTH(56), MAXFLOAT)];
    progressHUD.label.size = CGSizeMake(labelSize.width, labelSize.height);
    progressHUD.label.textAlignment = NSTextAlignmentLeft;
    progressHUD.label.numberOfLines = 0;
    return progressHUD;
}

- (void)pipelinethrowdelegate:(NSString *)text scjhideno:(BOOL)animated objectcall:(NSTimeInterval)delay;{
    self.callbackRobustnessHide = YES;
    self.mode = MBProgressHUDModeText;
    self.label.text = text;
    
    [self processarchivehandle:animated objectcall:delay];
    
    self.label.font = [UIFont systemFontOfSize:IPHONEWIDTH(35)];
    CGSize labelSize = [text sizeWithFont:[UIFont systemFontOfSize:IPHONEWIDTH(35)] constrainedToSize:CGSizeMake(ScreenWidth-IPHONEWIDTH(56), MAXFLOAT)];
    self.label.size = CGSizeMake(labelSize.width, labelSize.height);
    self.label.textAlignment = NSTextAlignmentLeft;
    self.label.numberOfLines = 0;
}

+(void)ShowProgressView:(UIView *)view animated:(BOOL)animated{
    ComponentsD *hud = [ComponentsD defaultCalendricalbug:view gwkanimatedbd:animated];
    //状态栏frame
    CGRect rectStatus = [[UIApplication sharedApplication] statusBarFrame];
    
    hud.frame = CGRectMake(0, 20+IPHONEHIGHT(88),ScreenWidth , ScreenHeight-20-IPHONEHIGHT(88));
    
}
@end
