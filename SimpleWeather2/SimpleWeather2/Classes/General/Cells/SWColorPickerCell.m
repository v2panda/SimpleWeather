//
//  SWColorPickerCell.m
//  SimpleWeather2
//
//  Created by Panda on 15/11/9.
//  Copyright © 2015年 Panda. All rights reserved.
//

#import "SWColorPickerCell.h"

@interface SWColorPickerCell ()//<UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *cpView;

@property (nonatomic,strong) UIPickerView *pickerView;

@end

@implementation SWColorPickerCell

- (void)awakeFromNib {
    // Initialization code
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    CGRect pickerFrame = CGRectMake(self.cpView.bounds.origin.x,self.cpView.bounds.origin.y,[UIScreen mainScreen].bounds.size.width,120);
    
    self.pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    
//    self.pickerView.delegate = self;
//    self.pickerView.dataSource = self;
    
    self.cpView.hidden = YES;
    [self performSelector:@selector(unHideCPView) withObject:self afterDelay:0.2];
    
//    LWNotificationCondition condition = [LWSettingsStore sharedStore].notificationCondition;
//    NSInteger row;
//    
//    if (condition == LWNotificationConditionDaily) {
//        row = 2;
//    } else if (condition == LWNotificationConditionRainOnly) {
//        row = 1;
//    } else {
//        row = 0;
//    }
//    [self.pickerView selectRow:0 inComponent:0 animated:NO];
    
    [self.cpView addSubview:self.pickerView];
    //[myPicker release];
    [self.contentView sizeToFit];
}

- (void)prepareForDeletion {
    self.cpView.hidden = YES;
}
- (void)unHideCPView {
    self.cpView.hidden = NO;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
