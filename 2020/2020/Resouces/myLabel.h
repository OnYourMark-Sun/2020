//
//  myLabel.h
//  单行透明度的变化,下拉变大,上拉显示tab
//
//  Created by 徐士友 on 16/8/26.
//  Copyright © 2016年 xujiahui. All rights reserved.
//

#import <UIKit/UIKit.h>
@class myLabel;
@interface myLabel : UILabel

+(myLabel*)labelWithframe:(CGRect)frame backgroundColor:(UIColor*)backgroundColor title:(NSString *)title font:(NSInteger)font Alignment:(NSTextAlignment)Alignment textColor:(UIColor*)textColor ;

@end
