//
//  RegisterAcademicViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/21/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "RegisterAcademicViewController.h"

@interface RegisterAcademicViewController ()
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIToolbar *pickerToolBar;
@property (nonatomic, strong) UIActionSheet *actionSheet;
@property (nonatomic, strong) NSString *selectedCellTitle;
@property (nonatomic, assign) NSInteger selectedTableIndex;
@property (nonatomic, assign) NSInteger selectedPickerIndex;
@property (nonatomic, strong) NSMutableArray *pickerData;
@end

@implementation RegisterAcademicViewController

#define GRADE @"Current Grade"
#define PERFORMANCE @"Performance"
#define FAVORITE_SUBJECTS @"Favorite Subjects"
#define GRADE_TAG 100
#define PERFORMANCE_TAG 200

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.academicData = [[NSMutableDictionary alloc] init];
    
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    
    //Create actionSheet and pickerToolbar..
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    [self.actionSheet setActionSheetStyle:UIActionSheetStyleBlackOpaque];
    
    self.pickerToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
    [self.pickerToolBar setBarStyle:UIBarStyleBlack];
}

- (void)createPicker
{
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, 0, 0)];
    self.pickerView.showsSelectionIndicator = YES;
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
}

- (void)cancelButtonPressed
{
    [self.actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)doneButtonPressed
{
    UIBarButtonItem *item = [self.pickerToolBar.items lastObject];
    NSString *title = [self.pickerData objectAtIndex:self.selectedPickerIndex];
    switch (item.tag) {
        case GRADE_TAG:
            [self.academicData setValue:title forKey:GRADE];
            break;
        case PERFORMANCE_TAG:
            [self.academicData setValue:title forKey:PERFORMANCE];
            break;
    }
    //Reset selected index, reload table and dismiss actionSheet
    //self.selectedTableIndex = 0;
    [self.tableView reloadData];
    [self.actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)addToolBarWithButtonsAndTitle:(NSString *)title andTag:(NSInteger)tag
{
    //Cancel Button..
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed)];
    
    //Title Label..
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 30)];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    UIBarButtonItem *titleButton = [[UIBarButtonItem alloc] initWithCustomView:titleLabel];
    titleButton.title = title;
    
    //Done Button..
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed)];
    doneButton.tag = tag;
    
    //Add to array, then add to toolbar..
    [barItems addObject:cancelButton];
    [barItems addObject:titleButton];
    [barItems addObject:doneButton];
    [self.pickerToolBar setItems:barItems animated:YES];
}

- (void)showPicker
{
    [self createPicker];
    NSString *title;
    NSInteger tag;
    switch (self.selectedTableIndex) {
        case 0:
            self.pickerData = [[NSMutableArray alloc] initWithObjects:@"Pre-K",
                               @"Kindergarden",
                               @"1st",
                               @"2nd",
                               @"3rd",
                               @"4th",
                               @"5th",
                               @"6th",
                               @"7th",
                               @"8th",
                               @"9th",
                               @"10th",
                               @"11th",
                               @"12th", nil];
            title = GRADE;
            tag = GRADE_TAG;
            break;
        case 1:
            self.pickerData = [[NSMutableArray alloc] initWithObjects:@"Very Poor", @"Poor", @"Average", @"Good", @"Very Good", nil];
            title = PERFORMANCE;
            tag = PERFORMANCE_TAG;
            break;
    }
    
    //Add picker to actionSheet..
    [self.actionSheet addSubview:self.pickerView];
    
    //Add buttons to toolbar and add to actionSheet..
    [self addToolBarWithButtonsAndTitle:title andTag:tag];
    [self.actionSheet addSubview:self.pickerToolBar];
    
    //Show actionSheet
    [self.actionSheet showInView:self.view];
    [self.actionSheet setBounds:CGRectMake(self.view.bounds.origin.x,
                                           self.view.bounds.origin.y,
                                           self.view.bounds.size.width,
                                           self.view.bounds.size.height + 30)];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.pickerData count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.pickerData objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedPickerIndex = row;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    switch ([indexPath row]) {
        case 0:
            cell.textLabel.text = GRADE;
            cell.detailTextLabel.text = [self.academicData valueForKey:GRADE];
            break;
        case 1:
            cell.textLabel.text = PERFORMANCE;
            cell.detailTextLabel.text = [self.academicData valueForKey:PERFORMANCE];
            break;
        case 2:
            cell.textLabel.text = FAVORITE_SUBJECTS;
            cell.detailTextLabel.text = [self.academicData valueForKey:FAVORITE_SUBJECTS];
            break;
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedTableIndex = [indexPath row];
    switch ([indexPath row]) {
        case 0:
            [self showPicker];
            break;
        case 1:
            [self showPicker];
            break;
        case 2:
            //Go to favorite subjects controller
            break;
    }
}

@end
