//
//  NSString+Date.m
//  SimpleWeather2
//
//  Created by Panda on 15/10/29.
//  Copyright © 2015年 Panda. All rights reserved.
//

#import "NSString+Date.h"

@implementation NSString (Date)
// 按指定格式获取当前时间，精确到分
+ (NSString *)today
{
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyyMMddHHmmss"];
    NSDate *today = [NSDate date];
    return [[formatter stringFromDate:today]substringToIndex:12];
}
@end
