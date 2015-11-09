//
//  SWSettingViewController.m
//  SimpleWeather2
//
//  Created by Panda on 15/11/5.
//  Copyright © 2015年 Panda. All rights reserved.
//

#import "SWSettingViewController.h"
#import "SWColorCell.h"
#import "SWColorPickerCell.h"

@interface SWSettingViewController ()

@property (nonatomic) BOOL isEditingColor;

@end

@implementation SWSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.isEditingColor = NO;
    [self.tableView registerNib:[UINib nibWithNibName:@"SWColorPickerCell" bundle:nil] forCellReuseIdentifier:@"colorPickerCell"];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.cellsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = nil;
    NSString* identifier = self.cellsArray[indexPath.row];//@"colorPickerCell"
    
    cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    
    if ([identifier isEqualToString:@"colorPickerCell"]) {
        NSLog(@"colorPickerCell");
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"这是TableView的Header。";
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    return @"这是TableView的Footer。";
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger row = indexPath.row;
    
    if ( row < self.cellsArray.count) {
        NSLog(@"改变颜色");
         NSString* identifier = self.cellsArray[row];
        if ([identifier isEqual:@"colorCell"]) {
             NSLog(@"self.isEditingColor1 : %d",self.isEditingColor);
            self.isEditingColor = !self.isEditingColor;
            NSLog(@"self.isEditingColor2 : %d",self.isEditingColor);
        } else {
            NSLog(@"else change color");
        }
    }
}


- (void)updateCellQueue
{
    self.isEditingColor = NO;
    
    if (!self.cellsArray) {
        self.cellsArray = [[NSMutableArray alloc] initWithArray:@[@"ConditionPromptCell"]];
    }
    
//    NSMutableArray *cells = self.cellsArray;
    [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    
    
}

#pragma mark - Setter & Getter

- (void)setIsEditingColor:(BOOL)isEditingColor
{
    NSLog(@"isEditingColor1 %d",isEditingColor);
//    isEditingColor = _isEditingColor;
    
    if (isEditingColor == _isEditingColor) {
        return;
    }
    NSLog(@"isEditingColor2 %d",isEditingColor);
    if (isEditingColor) {

        [self.cellsArray insertObject:@"colorPickerCell" atIndex:1];
        [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:1 inSection:0]] withRowAnimation:UITableViewRowAnimationBottom];
        _isEditingColor = YES;
    }else {
        [self.cellsArray removeObject:@"colorPickerCell"];
        
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
//        SWColorPickerCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];
//        [cell prepareForDeletion];
        
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
        
        /*cell = */[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        /* UILabel* title = (UILabel *)[cell.contentView viewWithTag:2];
         [title setText:[[LWSettingsStore sharedStore] conditionText]]; */
        
        _isEditingColor = NO;
//        [self updateCellQueue];
    }
}

- (NSMutableArray *)cellsArray
{
    if (!_cellsArray) {
        _cellsArray = [NSMutableArray arrayWithObjects:@"colorCell", nil];
    }
    return _cellsArray;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
