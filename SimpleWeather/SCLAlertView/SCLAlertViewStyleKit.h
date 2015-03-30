//
//  SCLAlertViewStyleKit.h
//  SCLAlertView
//
//  Created by Diogo Autilio on 9/26/14.
//  Copyright (c) 2014 AnyKey Entertainment. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface SCLAlertViewStyleKit : NSObject

// Images
+ (UIImage*)imageOfCheckmark;
+ (UIImage*)imageOfCross;
+ (UIImage*)imageOfNotice;
+ (UIImage*)imageOfWarning;
+ (UIImage*)imageOfInfo;
+ (UIImage*)imageOfEdit;


+ (void)drawCheckmark;
+ (void)drawCross;
+ (void)drawNotice;
+ (void)drawWarning;
+ (void)drawInfo;
+ (void)drawEdit;

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
