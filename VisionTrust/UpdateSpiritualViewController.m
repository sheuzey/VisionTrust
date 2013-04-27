//
//  UpdateSpiritualViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/25/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "UpdateSpiritualViewController.h"
#import "InputDataViewController.h"

@interface UpdateSpiritualViewController () <GetData>
@property (strong, nonatomic) UIActionSheet *actionSheet;
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) UIToolbar *pickerToolBar;
@property (nonatomic, assign) NSInteger selectedTableIndex;
@property (nonatomic, assign) NSInteger selectedPickerIndex;
@property (nonatomic, strong) NSMutableArray *pickerData;
@property (strong, nonatomic) NSArray *allActivities;
@property (nonatomic, strong) NSString *otherActivity;
@property (nonatomic, strong) NSString *progress;
@end

@implementation UpdateSpiritualViewController

#define BAPTISM @"baptism"
#define SALVATION @"salvation"
#define SPIRITUAL_ACTIVITIES @"spiritualActivities"
#define PROGRESS @"progress"
#define BAPTISM_TAG 100
#define SALVATION_TAG 200

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.allActivities = [[NSArray alloc] initWithObjects:@"Camp",
                          @"Church",
                          @"Sunday School",
                          @"Vacation Bible School",
                          @"Youth Activities",
                          @"Other", nil];
    
    self.progress = [self.spiritualData valueForKey:PROGRESS];
    self.spiritualActivities = [[NSMutableArray alloc] initWithArray:[self.spiritualData valueForKey:SPIRITUAL_ACTIVITIES]];
    self.otherActivity = [self.spiritualActivities lastObject];
    
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
        case BAPTISM_TAG:
            [self.spiritualData setValue:title forKey:BAPTISM];
            break;
        case SALVATION_TAG:
            [self.spiritualData setValue:title forKey:SALVATION];
            break;
    }
    //Reset selected index, reload table and dismiss actionSheet
    self.selectedPickerIndex = self.selectedTableIndex = 0;
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
            self.pickerData = [[NSMutableArray alloc] initWithObjects:@"Baptized", @"Not Baptized", nil];
            title = @"Baptism Status";
            tag = BAPTISM_TAG;
            break;
        case 1:
            self.pickerData = [[NSMutableArray alloc] initWithObjects:@"Saved", @"Not Sure", nil];
            title = @"Salvation Status";
            tag = SALVATION_TAG;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return [self.allActivities count];
            break;
        default:
            return 1;
            break;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"General";
            break;
        case 1:
            return @"Activities";
            break;
        default:
            return @"";
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    // Configure the cell...
    switch ([indexPath section]) {
        case 0:
            switch ([indexPath row]) {
                case 0:
                    cell.textLabel.text = @"Baptismal Status";
                    cell.detailTextLabel.text = [self.spiritualData valueForKey:BAPTISM];
                    break;
                case 1:
                    cell.textLabel.text = @"Salvation Status";
                    cell.detailTextLabel.text = [self.spiritualData valueForKey:SALVATION];
                    break;
            }
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        case 1:
            
            //If cell is in favorites, add check mark to cell..
            cell.textLabel.text = [self.allActivities objectAtIndex:[indexPath row]];
            if ([self.spiritualActivities containsObject:[self.allActivities objectAtIndex:[indexPath row]]])
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            if ([indexPath row] == [self.allActivities count] - 1) {
                cell.detailTextLabel.text = self.otherActivity;
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            else
                cell.detailTextLabel.text = nil;
            
            break;
        case 2:
            cell.textLabel.text = @"Spiritual Progress";
            cell.detailTextLabel.text = self.progress;
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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
            [self showPicker];
            break;
        case 1:
            //Reverse selection accessory if its not "other"..
            if ([indexPath row] != [self.allActivities count] - 1) {
                if ([cell accessoryType] == UITableViewCellAccessoryCheckmark) {
                    [cell setAccessoryType:UITableViewCellAccessoryNone];
                    [self.spiritualActivities removeObject:cell.textLabel.text];
                } else {
                    [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
                    [self.spiritualActivities addObject:cell.textLabel.text];
                }
            } else {
                [self performSegueWithIdentifier:@"InputData" sender:self];
            }
            break;
        case 2:
            [self performSegueWithIdentifier:@"InputData" sender:self];
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"InputData"]) {
        InputDataViewController *idvc = (InputDataViewController *)segue.destinationViewController;
        if (self.selectedTableIndex == 0) {
            idvc.titleString = @"Progress";
            idvc.dataString = self.progress;
        } else {
            idvc.titleString = @"Other";
            idvc.dataString = self.otherActivity;
        }
        idvc.delegate = self;
    }
}

- (void)giveBackData:(NSString *)data
{
    //Assign data recieved from input controller..
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (self.selectedTableIndex == 0)
        self.progress = data;
    else
        self.otherActivity = data;
    
    [self.tableView reloadData];
}

- (IBAction)doneButtonPressed:(id)sender {
    
    //If there is an otherActivity, add it to activities. Else add a blank activity (will be ignored when update occurs)..
    if (self.otherActivity)
        [self.spiritualActivities addObject:self.otherActivity];
    else
        [self.spiritualActivities addObject:@""];
    
    //Add progress if there is any...else, add a blank entry (will be ignored when update occurs)..
    if ([self.progress length] > 0)
        [self.spiritualData setValue:self.progress forKey:PROGRESS];
    else
        [self.spiritualData setValue:@"" forKey:PROGRESS];
    
    [self.spiritualData setValue:self.spiritualActivities forKey:SPIRITUAL_ACTIVITIES];
    [self.delegate spiritualInfo:self.spiritualData];
}

@end
