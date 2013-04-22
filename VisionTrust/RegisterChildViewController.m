//
//  RegisterViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/19/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "InputDataViewController.h"
#import "RegisterChildViewController.h"
#import "RegisterGuardianViewController.h"
#import "RegisterAcademicViewController.h"

@interface RegisterChildViewController () <GetData, GuardianRegistrationProtocol, AcademicRegistrationProtocol>
@property (nonatomic ,strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIPickerView *projectPicker;
@property (nonatomic, strong) UIToolbar *pickerToolBar;
@property (nonatomic, strong) UIActionSheet *actionSheet;
@property (nonatomic, strong) NSString *selectedCellTitle;
@property (nonatomic, assign) NSInteger selectedProject;
@property (nonatomic, strong) NSMutableArray *projects;
@property (nonatomic, strong) NSMutableDictionary *academicData;
@property (nonatomic, strong) NSMutableDictionary *childData;
@property (nonatomic, strong) NSMutableDictionary *guardianData;
@end

@implementation RegisterChildViewController

#define FIRST_NAME @"firstName"
#define LAST_NAME @"lastName"
#define DOB @"dob"
#define CITY @"city"
#define PROJECT @"project"
#define DATA_TAG 100
#define DOB_TAG 200
#define PROJECT_TAG 300

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Set background color..
    self.view.backgroundColor = [UIColor clearColor];
    UITableView *tv = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:tv];
    [self.view sendSubviewToBack:tv];

    self.childImageView.backgroundColor = [UIColor grayColor];
    self.childData = [[NSMutableDictionary alloc] init];
    self.tableView.backgroundView = nil;
    self.title = @"Child Registration";
    
    //Setup projects array
    NSArray *array = [[NSArray alloc] initWithArray:[self.database getAllProjects]];
    self.projects = [[NSMutableArray alloc] init];
    for (Project *project in array) {
        [self.projects addObject:project.name];
    }
    
    //Create actionSheet, toolBar, datePicker and projectPicker..
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    [self.actionSheet setActionSheetStyle:UIActionSheetStyleBlackOpaque];
    
    self.pickerToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
    [self.pickerToolBar setBarStyle:UIBarStyleBlack];
    
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, 0, 0)];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    
    self.projectPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, 0, 0)];
    self.projectPicker.showsSelectionIndicator = YES;
    self.projectPicker.dataSource = self;
    self.projectPicker.delegate = self;
}

- (void)cancelButtonPressed
{
    [self.actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)doneButtonPressed
{
    UIBarButtonItem *item = [self.pickerToolBar.items lastObject];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    NSString *string;
    switch (item.tag) {
        case DOB_TAG:
            [df setDateFormat:@"MM/dd/yyyy"];
            string = [df stringFromDate:self.datePicker.date];
            [self.childData setValue:string forKey:DOB];
            break;
        case PROJECT_TAG:
            string = [self.projects objectAtIndex:self.selectedProject];
            [self.childData setValue:string forKey:PROJECT];
            break;
    }
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

- (void)showDatePicker
{
    //Setup toolBar
    [self addToolBarWithButtonsAndTitle:@"Date of Birth" andTag:DOB_TAG];
    
    //Add datePicker and toolbar to actionSheet..
    [self.actionSheet addSubview:self.datePicker];
    [self.actionSheet addSubview:self.pickerToolBar];
    
    //Show actionSheet..
    [self.actionSheet showInView:self.view];
    [self.actionSheet setBounds:CGRectMake(self.view.bounds.origin.x,
                                           self.view.bounds.origin.y,
                                           self.view.bounds.size.width,
                                           self.view.bounds.size.height + 30)];
}

- (void)showProjectPicker
{
    //Sort projects array and add to actionSheet..
    [self.projects sortUsingSelector:@selector(compare:)];
    [self.actionSheet addSubview:self.projectPicker];
    
    //Add buttons to toolbar and add to actionSheet..
    [self addToolBarWithButtonsAndTitle:@"Projects" andTag:PROJECT_TAG];
    [self.actionSheet addSubview:self.pickerToolBar];
    
    //Show actionSheet
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
    return [self.projects count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.projects objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedProject = row;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 5;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if ([indexPath section] == 0) {
        switch ([indexPath row]) {
            case 0:
                cell.textLabel.text = @"First Name";
                cell.detailTextLabel.text = [self.childData valueForKey:FIRST_NAME];
                break;
            case 1:
                cell.textLabel.text = @"Last Name";
                cell.detailTextLabel.text = [self.childData valueForKey:LAST_NAME];
                break;
            case 2:
                cell.textLabel.text = @"Date of Birth";
                cell.detailTextLabel.text = [self.childData valueForKey:DOB];
                break;
            case 3:
                cell.textLabel.text = @"City";
                cell.detailTextLabel.text = [self.childData valueForKey:CITY];
                break;
            case 4:
                cell.textLabel.text = @"Project";
                cell.detailTextLabel.text = [self.childData valueForKey:PROJECT];
                break;
        }
    } else {
        cell.textLabel.text = @"Info";
        cell.detailTextLabel.text = nil;
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"General Info";
            break;
        case 1:
            return @"Academic";
            break;
        case 2:
            return @"Health";
            break;
        case 3:
            return @"Spiritual";
            break;
        case 4:
            return @"Home Life";
            break;
        case 5:
            return @"Guardian";
            break;
        default:
            return @"";
            break;
    }
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
                self.selectedCellTitle = @"First Name";
                [self performSegueWithIdentifier:@"InputData" sender:self];
                break;
            case 1:
                self.selectedCellTitle = @"Last Name";
                [self performSegueWithIdentifier:@"InputData" sender:self];
                break;
            case 2:
                self.selectedCellTitle = @"Date of Birth";
                [self showDatePicker];
                break;
            case 3:
                self.selectedCellTitle = @"City";
                [self performSegueWithIdentifier:@"InputData" sender:self];
                break;
            case 4:
                self.selectedCellTitle = @"Project";
                [self showProjectPicker];
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
        RegisterAcademicViewController *ravc = (RegisterAcademicViewController *)segue.destinationViewController;
        ravc.academicData = [[NSMutableDictionary alloc] initWithDictionary:self.academicData];
        ravc.delegate = self;
    } else if ([segue.identifier isEqualToString:@"GoToHealth"]) {
        
    } else if ([segue.identifier isEqualToString:@"GoToSpiritual"]) {
        
    } else if ([segue.identifier isEqualToString:@"GoToHomeLife"]) {
        
    } else if ([segue.identifier isEqualToString:@"GoToGuardian"]) {
        RegisterGuardianViewController *rgvc = (RegisterGuardianViewController *)segue.destinationViewController;
        rgvc.guardianData = [[NSMutableDictionary alloc] initWithDictionary:self.guardianData];
        rgvc.delegate = self;
    }
}

- (void)giveBackData:(NSString *)data
{
    //Set child data into childData dictionary..
    [self dismissViewControllerAnimated:YES completion:nil];
    if ([self.selectedCellTitle isEqualToString:@"First Name"]) {
        [self.childData setValue:data forKey:FIRST_NAME];
    } else if ([self.selectedCellTitle isEqualToString:@"Last Name"]) {
        [self.childData setValue:data forKey:LAST_NAME];
    } else if ([self.selectedCellTitle isEqualToString:@"Date of Birth"]) {
        [self.childData setValue:data forKey:DOB];
    } else if ([self.selectedCellTitle isEqualToString:@"City"]) {
        [self.childData setValue:data forKey:CITY];
    } else if ([self.selectedCellTitle isEqualToString:@"Project"]) {
        [self.childData setValue:data forKey:PROJECT];
    }
    [[self tableView] reloadData];
}

- (void)guardianInfo:(NSMutableDictionary *)info
{
    //Set guardian data into guardianData dictionary..
    self.guardianData = [[NSMutableDictionary alloc] initWithDictionary:info];
}

- (void)academicInfo:(NSMutableDictionary *)info
{
    //Set academic data into academicData dictionary..
    self.academicData = [[NSMutableDictionary alloc] initWithDictionary:info];
}

@end