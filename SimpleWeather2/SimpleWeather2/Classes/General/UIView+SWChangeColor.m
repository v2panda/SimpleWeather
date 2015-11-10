//
//  UIView+SWChangeColor.m
//  SimpleWeather2
//
//  Created by Panda on 15/11/10.
//  Copyright © 2015年 Panda. All rights reserved.
//

#import "UIView+SWChangeColor.h"

@implementation UIView (SWChangeColor)
- (void)changeColor:(UITableViewCell *)cell
{
    NSInteger themeColor = [UserDefaults integerForKey:@"ThemeColor"];
    UIView *view = cell.contentView;
    switch (themeColor) {
        case 1:
            view.backgroundColor = DefaultColor;
            break;
        case 2:
            view.backgroundColor = DefaultRed;
            break;
        case 3:
            view.backgroundColor = DefaultGray;
            break;
            
        default:
            break;
    }
}
@end
