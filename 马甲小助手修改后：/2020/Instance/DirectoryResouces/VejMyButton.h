//
//  VejMyButton.h
//  02-button的封装-block
//
//  Created by xsy on 16/6/16.
//  Copyright © 2016年 xsy2020. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VejMyButton;
@protocol myButtonDelegate <NSObject>
//在写协议方法的时候，最好将自身作为参数传出
-(void)myButtonClicked:(VejMyButton *)VejMyButton;

@end

//起别名  声明的是一个block类型
typedef void (^myButtonBlock) (VejMyButton *button);

@interface VejMyButton : UIButton


+(VejMyButton *)czbuttonWithTypeuy:(UIButtonType )type connectedreflection:(CGRect )frame uetitlethk:(NSString *)title loadbalancingscalable:(NSInteger)tag gclog:(id)delegate;

+(VejMyButton *)buttonWithType:(UIButtonType )type frame:(CGRect )frame title:(NSString *)title andBackground:(UIColor *)backgroundColor tag:(NSInteger)tag andBlock:(myButtonBlock)block;

+(VejMyButton *)buttonWithType:(UIButtonType )type frame:(CGRect )frame tag:(NSInteger)tag image:(NSString *)image andBlock:(myButtonBlock)block;
@end


