//
//  SWPageViewDataSource.h
//  SimpleWeather2
//
//  Created by Panda on 15/11/5.
//  Copyright © 2015年 Panda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SWPageViewDataSource : NSObject <UIPageViewControllerDataSource>

- (UIViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(UIViewController *)viewController;

@end
