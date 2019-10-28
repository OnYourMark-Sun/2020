//
//  KgyNumberViewCollectionViewCell.m
//  2020
//
//  Created by yurong on 2017/6/30.
//  Copyright © 2017年 yurong. All rights reserved.
//

#import "KgyNumberViewCollectionViewCell.h"

@implementation KgyNumberViewCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
      
        _label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, (ScreenWidth-IPHONEWIDTH(56+10))/5, (ScreenWidth-IPHONEWIDTH(56+10))/5)];
        //文字自适应 label大小
        _label.adjustsFontSizeToFitWidth = YES;
        _label.text = @"2";
        _label.textColor = [UIColor blackColor];
        _label.font = [UIFont boldSystemFontOfSize:IPHONEWIDTH(70)];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.layer.borderWidth = 1;
        _label.layer.borderColor = [UIColor grayColor].CGColor;
        _label.layer.shadowColor = [UIColor grayColor].CGColor;
        _label.layer.shadowOffset = CGSizeMake(2, 1);
        _label.layer.shadowOpacity = 1;
        self.contentView.layer.cornerRadius = IPHONEWIDTH(15);
        self.contentView.layer.masksToBounds = YES;
             [self.contentView addSubview:_label];

        
    }
    
    return self;
    
    
}
@end
