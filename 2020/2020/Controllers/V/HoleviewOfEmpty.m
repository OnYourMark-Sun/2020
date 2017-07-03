//
//  HoleviewOfEmpty.m
//  2020
//
//  Created by yurong on 2017/6/29.
//  Copyright © 2017年 yurong. All rights reserved.
//

#import "HoleviewOfEmpty.h"

@implementation HoleviewOfEmpty
+(UIView*)HoleViewOfEmptyWithNumber:(int)num andView:(CGFloat)width typenum:(int)type{
    
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
    if (type == 0 || !type) {
        //平常灰色的
        view.backgroundColor = qianhuise;
        
        
    }else if (type == 1){
      
        
        //千疮百孔
    int k = num;
    
    
    for (int i=0; i<k; i++) {
        UIView * vi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, view.frame.size.width/k*(k-i),  view.frame.size.width/k*(k-i))];
        vi.backgroundColor = [UIColor colorWithRed:(200-i*40)/255.0f green:(200-i*40)/255.0f blue:(200-i*40)/255.0f alpha:1];
        vi.layer.cornerRadius =view.frame.size.width/k*(k-i)/2;
        vi.center = view.center;
        [view addSubview:vi];
        
    }
    
    }
    else if (type ==2){
        //xuanzhuan
        
        UIImageView * imgvi = [[UIImageView alloc] initWithFrame:view.frame];
        imgvi.image = [UIImage imageNamed:@"xuanzhuan.jpg"];
        imgvi.contentMode = UIViewContentModeCenter;
        imgvi.layer.masksToBounds = YES;
        [view addSubview:imgvi];
        
    }
    else if (type ==3){
        //maquan
        
        UIImageView * imgvi = [[UIImageView alloc] initWithFrame:view.frame];
        imgvi.image = [UIImage imageNamed:@"maquan.jpg"];
        [view addSubview:imgvi];
        
    }
    else if (type ==4){
        //zhimaquan
        
        UIImageView * imgvi = [[UIImageView alloc] initWithFrame:view.frame];
        imgvi.image = [UIImage imageNamed:@"zhima.jpg"];

        [view addSubview:imgvi];
        
    }
    else if (type ==5){
        //zhimaquan
        
        UIImageView * imgvi = [[UIImageView alloc] initWithFrame:view.frame];
        imgvi.image = [UIImage imageNamed:@"liangdian.jpg"];
        imgvi.contentMode = UIViewContentModeTop;
        imgvi.layer.masksToBounds = YES;
        [view addSubview:imgvi];
        
    }
    
    
    
    return view;
}
@end
