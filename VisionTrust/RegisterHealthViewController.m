//
//  RegisterHealthViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/22/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "RegisterHealthViewController.h"
#import "InputDataViewController.h"

@interface RegisterHealthViewController () <GetData>
@property (strong, nonatomic) UIActionSheet *actionSheet;
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) UIToolbar *pickerToolBar;
@property (nonatomic, assign) NSInteger selectedTableIndex;
@property (nonatomic, assign) NSInteger selectedPickerIndex;
@property (nonatomic, strong) NSMutableArray *pickerData;
@end

@implementation RegisterHealthViewController

#define HEALTH @"healthCondition"
#define TREATMENT @"currentlyReceivingTreatment"
#define ILLNESS @"chronicIllness"
#define HEALTH_COMMENTS @"healthComments"
#define HEALTH_TAG 100
#define TREATMENT_TAG 200

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
        case HEALTH_TAG:
            [self.healthData setValue:title forKey:HEALTH];
            break;
        case TREATMENT_TAG:
            [self.healthData setValue:title forKey:TREATMENT];
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
            self.pickerData = [[NSMutableArray alloc] initWithObjects:@"Very Poor", @"Poor", @"Average", @"Good", @"Very Good", nil];
            title = @"Health";
            tag = HEALTH_TAG;
            break;
        case 1:
            self.pickerData = [[NSMutableArray alloc] initWithObjects:@"Yes", @"No", nil];
            title = @"Treatment";
            tag = TREATMENT_TAG;
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
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
                    cell.textLabel.text = @"Health";
                    cell.detailTextLabel.text = [self.healthData valueForKey:HEALTH];
                    break;
                case 1:
                    cell.textLabel.text = @"Medical Treatment";
                    cell.detailTextLabel.text = [self.healthData valueForKey:TREATMENT];
                    break;
            }
            break;
        case 1:
            switch ([indexPath row]) {
                case 0:
                    cell.textLabel.text = @"Illness Details";
                    cell.detailTextLabel.text = [self.healthData valueForKey:ILLNESS];
                    break;
                case 1:
                    cell.textLabel.text = @"Other Comments";
                    cell.detailTextLabel.text = [self.healthData valueForKey:HEALTH_COMMENTS];
                    break;
            }
            break;
    }

    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedTableIndex = [indexPath row];
    switch ([indexPath section]) {
        case 0:
            [self showPicker];
            break;
        case 1:
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
            idvc.dataString = [self.healthData valueForKey:ILLNESS];
            idvc.titleString = @"Illness";
        }
        else {
            idvc.dataString = [self.healthData valueForKey:HEALTH_COMMENTS];
            idvc.titleString = @"Comments";
        }
        idvc.delegate = self;
    }
}

- (void)giveBackData:(NSString *)data
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if (self.selectedTableIndex == 0)
        [self.healthData setValue:data forKey:ILLNESS];
    else
        [self.healthData setValue:data forKey:HEALTH_COMMENTS];
    
    [self.tableView reloadData];
}

- (IBAction)doneButtonPressed:(id)sender {
    [self.delegate healthInfo:self.healthData];
}

@end
