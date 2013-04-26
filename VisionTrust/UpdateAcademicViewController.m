//
//  RegisterAcademicViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/21/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "UpdateAcademicViewController.h"
#import "InputDataViewController.h"

@interface UpdateAcademicViewController () <GetData>
@property (nonatomic, strong) UIPickerView *pickerView;
@property (nonatomic, strong) UIToolbar *pickerToolBar;
@property (nonatomic, strong) UIActionSheet *actionSheet;
@property (nonatomic, strong) NSString *selectedCellTitle;
@property (nonatomic, assign) NSInteger selectedTableIndex;
@property (nonatomic, assign) NSInteger selectedPickerIndex;
@property (nonatomic, strong) NSMutableArray *pickerData;
@property (nonatomic, strong) NSArray *allSubjects;
@property (nonatomic, strong) NSString *otherSubject;
@end

@implementation UpdateAcademicViewController

#define GRADE @"currentGrade"
#define PERFORMANCE @"developmentLevel"
#define FAVORITE_SUBJECTS @"favoriteSubjects"
#define GRADE_TAG 100
#define PERFORMANCE_TAG 200

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    
    //Create actionSheet and pickerToolbar..
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    [self.actionSheet setActionSheetStyle:UIActionSheetStyleBlackOpaque];
    
    self.pickerToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
    [self.pickerToolBar setBarStyle:UIBarStyleBlack];
    
    self.allSubjects = [[NSArray alloc] initWithObjects:@"Art",
                        @"Geography",
                        @"History",
                        @"Language",
                        @"Math",
                        @"Physical Education",
                        @"Science",
                        @"Other", nil];
    self.otherSubject = [self.academicData valueForKey:@"other"];
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
    self.selectedPickerIndex = 0;
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
            title = @"Grade";
            tag = GRADE_TAG;
            break;
        case 1:
            self.pickerData = [[NSMutableArray alloc] initWithObjects:@"Very Poor", @"Poor", @"Average", @"Good", @"Very Good", nil];
            title = @"Performance";
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

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.pickerData objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedPickerIndex = row;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return @"General Info";
    return @"Favorite Subjects";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return 2;
    return [self.allSubjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    switch ([indexPath section]) {
        case 0:
            switch ([indexPath row]) {
                case 0:
                    cell.textLabel.text = @"Grade";
                    cell.detailTextLabel.text = [self.academicData valueForKey:GRADE];
                    break;
                case 1:
                    cell.textLabel.text = @"Performance";
                    cell.detailTextLabel.text = [self.academicData valueForKey:PERFORMANCE];
                    break;
            }
            break;
        case 1:
            //If cell is in favorites, add check mark to cell..
            cell.textLabel.text = [self.allSubjects objectAtIndex:[indexPath row]];
            if ([self.favoriteSubjects containsObject:[self.allSubjects objectAtIndex:[indexPath row]]])
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            if ([indexPath row] == [self.allSubjects count] - 1) {
                cell.detailTextLabel.text = self.otherSubject;
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            else
                cell.detailTextLabel.text = nil;
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    self.selectedTableIndex = [indexPath row];
    switch ([indexPath section]) {
        case 0:
            switch ([indexPath row]) {
                case 0:
                    [self showPicker];
                    break;
                case 1:
                    [self showPicker];
                    break;
            }
            break;
        case 1:
            
            //Reverse selection accessory if its not "other"..
            if ([indexPath row] != [self.allSubjects count] - 1) {
                if ([cell accessoryType] == UITableViewCellAccessoryCheckmark) {
                    [cell setAccessoryType:UITableViewCellAccessoryNone];
                    [self.favoriteSubjects removeObject:cell.textLabel.text];
                } else {
                    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
                    [self.favoriteSubjects addObject:cell.textLabel.text];
                }
            } else {
                [self performSegueWithIdentifier:@"InputData" sender:self];
            }
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"InputData"]) {
        InputDataViewController *idvc = (InputDataViewController *)segue.destinationViewController;
        idvc.titleString = @"Other";
        idvc.dataString = self.otherSubject;
        idvc.delegate = self;
    }
}

- (void)giveBackData:(NSString *)data
{
    [self dismissViewControllerAnimated:YES completion:nil];
    self.otherSubject = data;
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    if ([self.otherSubject length] > 0) {
        [self.favoriteSubjects addObject:self.otherSubject];
        [self.academicData setValue:self.otherSubject forKey:@"other"];
    }
    [self.academicData setValue:self.favoriteSubjects forKey:FAVORITE_SUBJECTS];
    [self.delegate academicInfo:self.academicData];
}

@end
