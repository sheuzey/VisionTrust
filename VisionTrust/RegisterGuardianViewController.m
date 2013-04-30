//
//  RegisterGuardianViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/20/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "RegisterGuardianViewController.h"
#import "InputDataViewController.h"

@interface RegisterGuardianViewController () <GetData, UIActionSheetDelegate, UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, strong) UIPickerView *projectPicker;
@property (nonatomic, strong) UIToolbar *pickerToolBar;
@property (nonatomic, strong) UIActionSheet *actionSheet;
@property (nonatomic, assign) NSInteger selectedPickerIndex;
@property (nonatomic, strong) NSMutableArray *pickerData;
@property (nonatomic, strong) NSString *selectedCellTitle;
@property (nonatomic, strong) NSString *selectedCellIdentifier;
@property (nonatomic, strong) VisionTrustDatabase *database;
@end

@implementation RegisterGuardianViewController

#define FNAME @"firstName"
#define LNAME @"lastName"
#define OCCUPATION @"occupation"
#define STATUS @"status"
#define STATUS_TAG 100

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Guardian";
    self.database = [VisionTrustDatabase vtDatabase];
    
    //Create actionSheet and toolBar..
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    [self.actionSheet setActionSheetStyle:UIActionSheetStyleBlackOpaque];
    
    self.pickerToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
    [self.pickerToolBar setBarStyle:UIBarStyleBlack];
}

- (void)cancelButtonPressed
{
    [self.actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)doneButtonPressed
{
    UIBarButtonItem *item = [self.pickerToolBar.items lastObject];
    switch (item.tag) {
        case STATUS_TAG:
            [self.guardianData setValue:[self.pickerData objectAtIndex:self.selectedPickerIndex] forKey:STATUS];
            break;
    }
    [self.tableView reloadData];
    self.selectedPickerIndex = 0;
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
    //Create picker..
    self.projectPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, 0, 0)];
    self.projectPicker.showsSelectionIndicator = YES;
    self.projectPicker.dataSource = self;
    self.projectPicker.delegate = self;
    
    if ([self.selectedCellTitle isEqualToString:@"Status"]) {
        
        //Setup gender array..
        self.pickerData = [[NSMutableArray alloc] initWithObjects:@"Alive",
                           @"Dead",
                           @"Abandoned Child",
                           @"Chronic Illness",
                           @"Incarcerated", nil];
        
        //Add buttons to toolbar..
        [self addToolBarWithButtonsAndTitle:@"Status" andTag:STATUS_TAG];
    }
    
    //Add picker and toolbar to actionSheet and show..
    [self.actionSheet addSubview:self.projectPicker];
    [self.actionSheet addSubview:self.pickerToolBar];
    [self.actionSheet showInView:self.view];
    [self.actionSheet setBounds:CGRectMake(self.view.bounds.origin.x,
                                           self.view.bounds.origin.y,
                                           self.view.bounds.size.width,
                                           self.view.bounds.size.height + 30)];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.pickerData count];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];

    //Configure cell...
    switch ([indexPath row]) {
        case 0:
            cell.textLabel.text = @"First Name";
            cell.detailTextLabel.text = [self.guardianData valueForKey:FNAME];
            break;
        case 1:
            cell.textLabel.text = @"Last Name";
            cell.detailTextLabel.text = [self.guardianData valueForKey:LNAME];
            break;
        case 2:
            cell.textLabel.text = @"Occupation";
            cell.detailTextLabel.text = [self.guardianData valueForKey:OCCUPATION];
            break;
        case 3:
            cell.textLabel.text = @"Status";
            cell.detailTextLabel.text = [self.guardianData valueForKey:STATUS];
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([indexPath row]) {
        case 0:
            self.selectedCellTitle = @"First Name";
            self.selectedCellIdentifier = FNAME;
            [self performSegueWithIdentifier:@"InputData" sender:self];
            break;
        case 1:
            self.selectedCellTitle = @"Last Name";
            self.selectedCellIdentifier = LNAME;
            [self performSegueWithIdentifier:@"InputData" sender:self];
            break;
        case 2:
            self.selectedCellTitle = @"Occupation";
            self.selectedCellIdentifier = OCCUPATION;
            [self performSegueWithIdentifier:@"InputData" sender:self];
            break;
        case 3:
            self.selectedCellTitle = @"Status";
            [self showPicker];
            break;
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"InputData"]) {
        InputDataViewController *idvc = (InputDataViewController *)segue.destinationViewController;
        idvc.titleString = self.selectedCellTitle;
        idvc.dataString = [self.guardianData valueForKey:self.selectedCellIdentifier];
        idvc.delegate = self;
    }
}

- (void)giveBackData:(NSString *)data
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    if ([self.selectedCellTitle isEqualToString:@"First Name"]) {
        [self.guardianData setValue:data forKey:FNAME];
    } else if ([self.selectedCellTitle isEqualToString:@"Last Name"]) {
        [self.guardianData setValue:data forKey:LNAME];
    } else if ([self.selectedCellTitle isEqualToString:@"Occupation"]) {
        [self.guardianData setValue:data forKey:OCCUPATION];
    }
    
    [[self tableView] reloadData];
}


- (IBAction)doneButtonPressed:(id)sender {
    [self.delegate guardianInfo:self.guardianData];
    
}

@end
