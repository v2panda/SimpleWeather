//
//  SWNetHelper.h
//  SimpleWeather2
//
//  Created by Panda on 15/10/29.
//  Copyright © 2015年 Panda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWNetHelper : NSObject

// 请求成功之后回调的 Block
typedef void(^SuccessBlock) (AFHTTPRequestOperation *operation, id responseObject);

// 请求失败之后回调的 Block
typedef void(^FailBlock) (AFHTTPRequestOperation *operation, NSError *error);

/**
 *  获取天气数据
 *
 *  @param date    日期，"yyyy-MM-dd"格式
 *  @param success 请求成功 Block
 *  @param fail     请求失败 Block
 */
+ (void)getWeatherByAreaid:(NSString *)areaid Type:(NSString *)type Date:(NSString *)date success:(SuccessBlock)success failBlock:(FailBlock)fail;

@end
