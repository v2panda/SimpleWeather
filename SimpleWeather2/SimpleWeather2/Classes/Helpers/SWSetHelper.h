//
//  SWSetHelper.h
//  SimpleWeather2
//
//  Created by Panda on 15/11/10.
//  Copyright © 2015年 Panda. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,ThemeColor) {
    ThemeColorDefault   = 1,
    ThemeColor1         = 2,
    ThemeColor2         = 3,
};


@interface SWSetHelper : NSObject

+ (instancetype)sharedCondition;
- (NSString *)colorString;
- (void)saveChanges;

@property (nonatomic, assign) ThemeColor themeColor;

@end
