//
//  FjChinesePinyin.m
//  2020
//
//  Created by yurong on 2017/6/29.
//  Copyright © 2017年 yurong. All rights reserved.
//

#import "FjChinesePinyin.h"

@implementation FjChinesePinyin
+ (NSString *)transform:(NSString *)chinese
{
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    NSLog(@"%@", pinyin);
    return [pinyin uppercaseString];
}
@end
