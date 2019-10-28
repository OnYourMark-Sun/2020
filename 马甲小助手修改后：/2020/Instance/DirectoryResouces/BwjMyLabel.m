//
//  BwjMyLabel.m
//  单行透明度的变化,下拉变大,上拉显示tab
//
//  Created by 徐士友 on 16/8/26.
//  Copyright © 2016年 xujiahui2020. All rights reserved.
//

#import "BwjMyLabel.h"

@implementation BwjMyLabel

+(BwjMyLabel*)interfaceformMessage:(CGRect)frame assignmentObject:(UIColor *)backgroundColor uetitlethk:(NSString *)title deferlookuptable:(NSInteger)font mxAlignmentok:(NSTextAlignment)Alignment initializemessage:(UIColor *)textColor{
    
    BwjMyLabel * label = [[BwjMyLabel alloc] initWithFrame:frame];
    
    label.backgroundColor = backgroundColor;
    
    label.text = title;
    
    label.textColor = textColor;
    
    label.textAlignment = Alignment;
    
    label.font = [UIFont systemFontOfSize:font];
    
    
    return label;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
