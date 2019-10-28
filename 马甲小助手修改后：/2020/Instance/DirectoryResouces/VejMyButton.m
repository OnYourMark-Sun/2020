//
//  VejMyButton.m
//  02-button的封装-block
//
//  Created by 碧海 on 16/6/16.
//  Copyright © 2016年 碧海. All rights reserved.
//

#import "VejMyButton.h"
@interface VejMyButton()
@property (nonatomic,assign) id<myButtonDelegate>delegate;

@property (nonatomic,copy) myButtonBlock block;
@end

@implementation VejMyButton
+(VejMyButton *)czbuttonWithTypeuy:(UIButtonType )type connectedreflection:(CGRect )frame uetitlethk:(NSString *)title loadbalancingscalable:(NSInteger)tag gclog:(id)delegate{
    VejMyButton *button = [VejMyButton buttonWithType:type];
    
    button.frame =  frame;
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button addTarget:button action:@selector(schedulersequentialcommit:) forControlEvents:UIControlEventTouchUpInside];
    
    button.tag = tag;
    
    button.delegate = delegate;
    
    return button;

}

+(VejMyButton *)buttonWithType:(UIButtonType )type frame:(CGRect )frame title:(NSString *)title andBackground:(UIColor *)backgroundColor tag:(NSInteger)tag andBlock:(myButtonBlock)block{
    VejMyButton *button = [VejMyButton buttonWithType:type];
    
    button.frame =  frame;
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button addTarget:button action:@selector(schedulersequentialcommit:) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = backgroundColor;
    
    button.tag = tag;
    
    button.block = block;
    
    return button;
    
}


-(void)schedulersequentialcommit:(UIButton *)btn{
    
    
//    //调用协议方法
//    if ([_delegate respondsToSelector:@selector(myButtonClicked:)]) {
//        [_delegate performSelector:@selector(myButtonClicked:) withObject:self];
//    }
    
    self.block(self);
}

+(VejMyButton *)buttonWithType:(UIButtonType)type frame:(CGRect)frame  tag:(NSInteger)tag image:(NSString *)image andBlock:(myButtonBlock)block{
    VejMyButton *button = [VejMyButton buttonWithType:type];
    
    button.frame =  frame;
    
    [button addTarget:button action:@selector(schedulersequentialcommit:) forControlEvents:UIControlEventTouchUpInside];
    
    if ([image hasPrefix:@"http:"] || [image hasPrefix:@"https:"]) {
        
        //[button setImageForState:UIControlStateNormal withURL:[NSURL URLWithString:image]];
    }else{
        [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    }
    
    button.layer.masksToBounds = YES;
    button.layer.cornerRadius = 9;
    
    button.tag = tag;
    
    button.block = block;
    
    return button;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
