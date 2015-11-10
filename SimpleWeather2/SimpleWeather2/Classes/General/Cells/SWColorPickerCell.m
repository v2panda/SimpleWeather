//
//  SWColorPickerCell.m
//  SimpleWeather2
//
//  Created by Panda on 15/11/9.
//  Copyright © 2015年 Panda. All rights reserved.
//

#import "SWColorPickerCell.h"
#import "SWSetHelper.h"

@interface SWColorPickerCell ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *cpView;

@property (nonatomic,strong) UIPickerView *pickerView;

@end

@implementation SWColorPickerCell

- (void)awakeFromNib {
    // Initialization code
    self.contentView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
    CGRect pickerFrame = CGRectMake(0,0,[UIScreen mainScreen].bounds.size.width,120);
    
    self.pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];
    
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;
    
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

    [self.contentView sizeToFit];
}

#pragma mark - UIPickerViewDataSource & UIPickerViewDelegate
// returns the number of 'columns' to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 3;
}

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component != 0) {
        return nil;
    }
    UIColor *lwBlueColor = [UIColor colorWithRed:((float)((0x49CFEC & 0xFF0000) >> 16))/255.0 \
                                           green:((float)((0x49CFEC & 0x00FF00) >>  8))/255.0 \
                                            blue:((float)((0x49CFEC & 0x0000FF) >>  0))/255.0 \
                                           alpha:1.0];
    
    switch (row) {
        case 0:
            return [[NSAttributedString alloc] initWithString:@"默认" attributes:@{NSForegroundColorAttributeName:lwBlueColor}];
            break;
        case 1:
            return [[NSAttributedString alloc] initWithString:@"color1" attributes:@{NSForegroundColorAttributeName:lwBlueColor}];
            break;
        case 2:
            return [[NSAttributedString alloc] initWithString:@"color2" attributes:@{NSForegroundColorAttributeName:lwBlueColor}];
            break;
        default:
            return nil;
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"row-%ld,component-%ld",(long)row,(long)component);
    
    switch (row) {
        case 0:
            [SWSetHelper sharedCondition].themeColor = ThemeColorDefault;
            break;
        case 1:
            [SWSetHelper sharedCondition].themeColor = ThemeColor1;
            break;
        case 2:
            [SWSetHelper sharedCondition].themeColor = ThemeColor2;
            break;
            
        default:
            break;
    }
    [[SWSetHelper sharedCondition]saveChanges];
    UITableViewCell *promptCell = [self.settingVC.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    UILabel* title = (UILabel *)[promptCell.contentView viewWithTag:1];
    [title setText:[[SWSetHelper sharedCondition] colorString]];
    [self changeColor:self];
    [self.settingVC changeColor];
    
//    [self.settingVC conditionPickerDidChangeSelection];
    
}

#pragma mark - UITableViewCell prepareForReuse

- (void)prepareForReuse
{
    [self performSelector:@selector(unHideCPView) withObject:nil afterDelay:0.2];
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
