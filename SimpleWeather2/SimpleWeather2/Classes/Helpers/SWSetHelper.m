//
//  SWSetHelper.m
//  SimpleWeather2
//
//  Created by Panda on 15/11/10.
//  Copyright © 2015年 Panda. All rights reserved.
//

#import "SWSetHelper.h"


@implementation SWSetHelper

+ (instancetype)sharedCondition
{
    static SWSetHelper* sharedCondition = nil;
    
    if (!sharedCondition) {
        sharedCondition = [[self alloc] initPrivate];
    }
    return sharedCondition;
}

- (instancetype)init
{
    @throw [NSException exceptionWithName:@"Singleton"
                                   reason:@"Use +[SWSetHelper sharedCondition]"
                                 userInfo:nil];
    return nil;
}

- (instancetype)initPrivate
{
    self = [super init];
    if (self) {
        _themeColor = [UserDefaults integerForKey:@"ThemeColor"];
        
        if (!_themeColor) {
            _themeColor = ThemeColorDefault;
        }
        
    }
    return self;
}

- (NSString *)colorString
{
    if (self.themeColor == ThemeColorDefault) {
        return @"默认";
    }else if(self.themeColor == ThemeColor1){
        return @"1";
    }
    return @"2";
}

- (void)saveChanges
{
    [UserDefaults setInteger:self.themeColor forKey:@"ThemeColor"];
    [UserDefaults synchronize];
}
@end
