//
//  Constants.h
//  SimpleWeather2
//
//  Created by Panda on 15/10/29.
//  Copyright © 2015年 Panda. All rights reserved.
//

#ifndef Constants_h
#define Constants_h

#define RGB(r, g, b)                        [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0]
#define RGBA(r, g, b, a)                    [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

//默认颜色
#define DefaultColor RGB(22, 191, 255)
#define DefaultRed RGB(224, 51, 51)
#define DefaultGray RGB(133 , 132, 116)
#define DefaultGreen RGB(34, 181, 115)

#define UserDefaults [NSUserDefaults standardUserDefaults]

#endif /* Constants_h */
