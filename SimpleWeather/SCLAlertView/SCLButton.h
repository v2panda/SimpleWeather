//
//  SCLButton.h
//  SCLAlertView
//
//  Created by Diogo Autilio on 9/26/14.
//  Copyright (c) 2014 AnyKey Entertainment. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCLButton : UIButton

typedef void (^ActionBlock)(void);

// Action Types
typedef NS_ENUM(NSInteger, SCLActionType)
{
    None,
    Selector,
    Block
};


@property SCLActionType actionType;

@property (nonatomic, copy) ActionBlock actionBlock;

@property id target;

@property SEL selector;

@end

// 版权属于原作者
// http://code4app.com (cn) http://code4app.net (en)
// 发布代码于最专业的源码分享网站: Code4App.com 
