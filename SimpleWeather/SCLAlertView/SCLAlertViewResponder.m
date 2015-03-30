//
//  SCLAlertViewResponder.m
//  SCLAlertView
//
//  Created by Diogo Autilio on 9/26/14.
//  Copyright (c) 2014 AnyKey Entertainment. All rights reserved.
//

#import "SCLAlertViewResponder.h"

@interface SCLAlertViewResponder ()

@property SCLAlertView *alertview;

@end

@implementation SCLAlertViewResponder

//
//// Allow alerts to be closed/renamed in a chainable manner
//// Example: SCLAlertView().showSuccess(self, title: "Test", subTitle: "Value").close()

// Initialisation and Title/Subtitle/Close functions
- (instancetype)init:(SCLAlertView *)alertview
{
    self.alertview = alertview;
    return self;
}

- (void)setTitletitle:(NSString *)title
{
    self.alertview.labelTitle.text = title;
}

- (void)setSubTitle:(NSString *)subTitle
{
    self.alertview.viewText.text = subTitle;
}

- (void)close
{
    [self.alertview hideView];
}

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
