//
//  MainHeader.h
//  SimpleWeather
//
//  Created by 徐臻 on 15/3/6.
//  Copyright (c) 2015年 xuzhen. All rights reserved.
//

#ifndef SimpleWeather_MainHeader_h
#define SimpleWeather_MainHeader_h

//
#define IS_IOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7)
#define IS_IOS8 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8)
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define KDeviceHeight [UIScreen mainScreen].bounds.size.height
//默认颜色
#define DefaultColor RGB(22, 191, 255)
#define DefaultRed RGB(224, 51, 51)
#define DefaultYellow RGB(133 , 132, 116)
#define DefaultGreen RGB(34, 181, 115)

#endif
