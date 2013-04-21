//
//  RegisterViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/19/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "RegisterChildViewController.h"
#import "InputDataViewController.h"
#import "RegisterGuardianViewController.h"

@interface RegisterChildViewController () <GetData>
@property (nonatomic, strong) NSString *selectedCellTitle;
@property (nonatomic, strong) NSMutableDictionary *childData;
@property (nonatomic ,strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIToolbar *pickerToolBar;
@property (nonatomic, strong) UIActionSheet *actionSheet;
@end

@implementation RegisterChildViewController

#define FIRST_NAME @"First Name"
#define LAST_NAME @"Last Name"
#define DOB @"Date of Birth"
#define CITY @"City"
#define PROJECT @"Project"

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [super tableView].delegate = self;
    [super tableView].dataSource = self;
    [super childImageView].backgroundColor = [UIColor grayColor];
    self.childData = [[NSMutableDictionary alloc] init];
    self.title = @"Child Registration";
    
    [self setupDatePicker];
}

- (void)cancelButtonPressed
{
    [self.actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)doneButtonPressed
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"MM/dd/yyyy"];
    NSString *dateString = [df stringFromDate:self.datePicker.date];
    
    [self.childData setValue:dateString forKey:DOB];
    [self.tableView reloadData];
    [self.actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)setupDatePicker
{
    //Create actionSheet, toolBar and datePicker..
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    [self.actionSheet setActionSheetStyle:UIActionSheetStyleBlackOpaque];
    
    self.pickerToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
    [self.pickerToolBar setBarStyle:UIBarStyleBlack];
    
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, 0, 0)];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    
    //Setup toolBar
    //Cancel Button..
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed)];
    
    //Title Label..
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 30)];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setText:@"Date of Birth"];
    UIBarButtonItem *titleButton = [[UIBarButtonItem alloc] initWithCustomView:titleLabel];
    titleButton.title = @"Date of Birth";
    
    //Done Button..
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed)];
    
    //Add to array, then add to toolbar..
    [barItems addObject:cancelButton];
    [barItems addObject:titleButton];
    [barItems addObject:doneButton];
    [self.pickerToolBar setItems:barItems animated:YES];
    
    //Add datePicker and toolbar to actionSheet..
    [self.actionSheet addSubview:self.datePicker];
    [self.actionSheet addSubview:self.pickerToolBar];
}

- (void)showPicker
{
    //Show actionSheet..
    [self.actionSheet showInView:self.view];
    [self.actionSheet setBounds:CGRectMake(self.view.bounds.origin.x,
                                           self.view.bounds.origin.y,
                                           self.view.bounds.size.width,
                                           self.view.bounds.size.height + 30)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [super tableView:tableView numberOfRowsInSection:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [super numberOfSectionsInTableView:tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    if ([indexPath section] == 0) {
        switch ([indexPath row]) {
            case 0:
                cell.detailTextLabel.text = [self.childData valueForKey:FIRST_NAME];
                break;
            case 1:
                cell.detailTextLabel.text = [self.childData valueForKey:LAST_NAME];
                break;
            case 2:
                cell.detailTextLabel.text = [self.childData valueForKey:DOB];
                break;
            case 3:
                cell.detailTextLabel.text = [self.childData valueForKey:CITY];
                break;
            case 4:
                cell.detailTextLabel.text = [self.childData valueForKey:PROJECT];
                break;
        }
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [super tableView:tableView titleForHeaderInSection:section];
}

- (IBAction)registerButtonPressed:(id)sender {
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] > 0) {
        switch ([indexPath section]) {
            case 1:
                [self performSegueWithIdentifier:@"GoToAcademic" sender:self];
                break;
            case 2:
                [self performSegueWithIdentifier:@"GoToHealth" sender:self];
                break;
            case 3:
                [self performSegueWithIdentifier:@"GoToSpiritual" sender:self];
                break;
            case 4:
                [self performSegueWithIdentifier:@"GoToHomeLife" sender:self];
                break;
            case 5:
                [self performSegueWithIdentifier:@"GoToGuardian" sender:self];
                break;
        }
    } else {
        switch ([indexPath row]) {
            case 0:
                self.selectedCellTitle = FIRST_NAME;
                [self performSegueWithIdentifier:@"InputData" sender:self];
                break;
            case 1:
                self.selectedCellTitle = LAST_NAME;
                [self performSegueWithIdentifier:@"InputData" sender:self];
                break;
            case 2:
                self.selectedCellTitle = DOB;
                [self showPicker];
                break;
            case 3:
                self.selectedCellTitle = CITY;
                [self performSegueWithIdentifier:@"InputData" sender:self];
                break;
            case 4:
                self.selectedCellTitle = PROJECT;
                [self performSegueWithIdentifier:@"InputData" sender:self];
                break;
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"InputData"]) {
        InputDataViewController *idvc = (InputDataViewController *)segue.destinationViewController;
        idvc.titleString = self.selectedCellTitle;
        idvc.dataString = [self.childData valueForKey:self.selectedCellTitle];
        idvc.delegate = self;
    } else if ([segue.identifier isEqualToString:@"GoToAcademic"]) {
        
    } else if ([segue.identifier isEqualToString:@"GoToHealth"]) {
        
    } else if ([segue.identifier isEqualToString:@"GoToSpiritual"]) {
        
    } else if ([segue.identifier isEqualToString:@"GoToHomeLife"]) {
        
    } else if ([segue.identifier isEqualToString:@"GoToGuardian"]) {
        
    }
}

- (void)giveBackData:(id)data
{
    if ([self.selectedCellTitle isEqualToString:FIRST_NAME]) {
        [self.childData setValue:data forKey:FIRST_NAME];
    } else if ([self.selectedCellTitle isEqualToString:LAST_NAME]) {
        [self.childData setValue:data forKey:LAST_NAME];
    } else if ([self.selectedCellTitle isEqualToString:DOB]) {
        [self.childData setValue:data forKey:DOB];
    } else if ([self.selectedCellTitle isEqualToString:CITY]) {
        [self.childData setValue:data forKey:CITY];
    } else if ([self.selectedCellTitle isEqualToString:PROJECT]) {
        [self.childData setValue:data forKey:PROJECT];
    }
    [[self tableView] reloadData];
}

@end