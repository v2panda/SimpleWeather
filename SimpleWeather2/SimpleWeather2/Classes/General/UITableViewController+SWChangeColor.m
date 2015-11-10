//
//  UITableViewController+SWChangeColor.m
//  SimpleWeather2
//
//  Created by Panda on 15/11/10.
//  Copyright © 2015年 Panda. All rights reserved.
//

#import "UITableViewController+SWChangeColor.h"

@implementation UITableViewController (SWChangeColor)
- (void)changeColor
{
    NSInteger themeColor = [UserDefaults integerForKey:@"ThemeColor"];
    switch (themeColor) {
        case 1:
            self.tableView.backgroundColor = DefaultColor;
            break;
        case 2:
            self.tableView.backgroundColor = DefaultRed;
            break;
        case 3:
            self.tableView.backgroundColor = DefaultGray;
            break;
            
        default:
            break;
    }
}
@end
