//
//  SWPageViewDataSource.m
//  SimpleWeather2
//
//  Created by Panda on 15/11/5.
//  Copyright © 2015年 Panda. All rights reserved.
//

#import "SWPageViewDataSource.h"
#import "SWHomeViewController.h"
#import "SWSettingViewController.h"

@interface SWPageViewDataSource ()

@property (nonatomic, copy) NSArray *viewControllers;

@end

@implementation SWPageViewDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        _viewControllers = @[@"HomeViewController",@"SettingViewController"];
    }
    return self;
}


- (UIViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{
    if (index == 0) {
        SWHomeViewController *homeVC = [storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
        return homeVC;
    }else if(index == 1){
        SWSettingViewController *settingVC = [storyboard instantiateViewControllerWithIdentifier:@"SettingViewController"];
        return settingVC;
    }else{
        return nil;
    }
}

- (NSUInteger)indexOfViewController:(UIViewController *)viewController {

    NSString *identifier = viewController.restorationIdentifier;
    return [self.viewControllers indexOfObject:identifier];
    
}

#pragma mark - UIPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:viewController];
    if (index == 1) {
        SWHomeViewController *homeVC = [viewController.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
        return homeVC;
    }
    return nil;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:viewController];
    if (index == 0) {
        SWSettingViewController *settingsVC = [viewController.storyboard instantiateViewControllerWithIdentifier:@"SettingViewController"];
        return settingsVC;
    }
    return nil;
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    return 2;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    return 0;
}

@end

