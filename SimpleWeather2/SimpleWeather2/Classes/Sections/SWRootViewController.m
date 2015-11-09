//
//  SWRootViewController.m
//  SimpleWeather2
//
//  Created by Panda on 15/11/5.
//  Copyright © 2015年 Panda. All rights reserved.
//

#import "SWRootViewController.h"
#import "SWPageViewDataSource.h"

@interface SWRootViewController ()

@property (nonatomic, strong) SWPageViewDataSource *pageDataSource;

@end

@implementation SWRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initPageViewController];
    
}

- (void)initPageViewController
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    self.pageViewController = [storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
    self.pageViewController.dataSource = self.pageDataSource;

    UIViewController *startViewController = [self.pageDataSource viewControllerAtIndex:0 storyboard:self.storyboard];
    NSArray *viewControllers = @[startViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    self.view.gestureRecognizers = self.pageViewController.gestureRecognizers;
    
    CGRect pageViewRect = self.view.bounds;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
        pageViewRect = CGRectInset(pageViewRect, 40.0, 40.0);
    }
    self.pageViewController.view.frame = pageViewRect;
    
    [self.pageViewController didMoveToParentViewController:self];

}

#pragma mark - Method Getter 

- (SWPageViewDataSource *)pageDataSource
{
    if (!_pageDataSource) {
        _pageDataSource = [[SWPageViewDataSource alloc]init];
    }
    return _pageDataSource;
}

#pragma mark - Setting

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
