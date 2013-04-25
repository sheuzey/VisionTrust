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
#import "RegisterHealthViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <QuartzCore/QuartzCore.h>

@interface RegisterChildViewController () <GetData, GuardianRegistrationProtocol, HealthRegistrationProtocol, UIImagePickerControllerDelegate, UINavigationBarDelegate, UIAlertViewDelegate>
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIPickerView *projectPicker;
@property (nonatomic, strong) UIToolbar *pickerToolBar;
@property (nonatomic, strong) UIActionSheet *actionSheet;
@property (nonatomic, strong) NSString *selectedCellTitle;
@property (nonatomic, strong) NSString *selectedCellIdentifier;
@property (nonatomic, assign) NSInteger selectedIndex;
@property (nonatomic, strong) NSMutableArray *pickerData;
@property (nonatomic, strong) UIPopoverController *imagePopover;
@property (nonatomic, strong) NSMutableDictionary *childData;
@property (nonatomic, strong) NSMutableDictionary *healthData;
@property (nonatomic, strong) NSMutableArray *guardians;
@end

@implementation RegisterChildViewController

#define FIRST_NAME @"firstName"
#define LAST_NAME @"lastName"
#define GENDER @"gender"
#define DOB @"dob"
#define ADDRESS @"address"
#define CITY @"city"
#define COUNTRY @"country"
#define PROJECT @"project"
#define PICTURE_DATA @"pictureData"

#define GENDER_TAG 100
#define DOB_TAG 200
#define PROJECT_TAG 300

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.database = [VisionTrustDatabase vtDatabase];
    
    self.guardians = [[NSMutableArray alloc] init];
    
    //Set background color..
    self.view.backgroundColor = [UIColor clearColor];
    UITableView *tv = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:tv];
    [self.view sendSubviewToBack:tv];

    //Add gesture recognizer to imageView..
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageWasTapped:)];
    [self.childImageView addGestureRecognizer:tapRecognizer];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, 40, 375, 20)];
    [label setBackgroundColor:[UIColor clearColor]];
    label.text = @"Take picture";
    label.tag = 100;
    [self.childImageView addSubview:label];
    self.childImageView.layer.masksToBounds = YES;
    self.childImageView.layer.cornerRadius = 10.0;
    self.childImageView.layer.borderWidth = 2.5;

    self.childData = [[NSMutableDictionary alloc] init];
    self.tableView.backgroundView = nil;
    self.title = @"Child Registration";
    
    //Create actionSheet, toolBar, datePicker and projectPicker..
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    [self.actionSheet setActionSheetStyle:UIActionSheetStyleBlackOpaque];
    
    self.pickerToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
    [self.pickerToolBar setBarStyle:UIBarStyleBlack];
    
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, 0, 0)];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
}

#define IMAGE_PICKER_IN_POPOVER YES

- (void)imageWasTapped:(UITapGestureRecognizer *)tapGesture
{
    if(!self.imagePopover && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        if([mediaTypes containsObject:(NSString *)kUTTypeImage]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeImage];
            picker.allowsEditing = YES;
            if(IMAGE_PICKER_IN_POPOVER && (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)) {
                self.imagePopover = [[UIPopoverController alloc] initWithContentViewController:picker];
                [self.imagePopover presentPopoverFromRect:self.view.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            } else {
                [self presentViewController:picker animated:YES completion:nil];
            }
        }
    }
}

- (void)dismissImagePicker
{
    [self.imagePopover dismissPopoverAnimated:YES];
    self.imagePopover = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if(!image) image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if(image) {
        [self.childImageView setContentMode:UIViewContentModeScaleAspectFit];
        [self.childImageView setImage:image];
    }
    [self.childData setValue:UIImagePNGRepresentation(self.childImageView.image) forKey:PICTURE_DATA];
    
    //Remove label..
    for (UIView *view in self.childImageView.subviews) {
        if (view.tag == 100)
            [view removeFromSuperview];
    }
    [self dismissImagePicker];
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
            string = [self.pickerData objectAtIndex:self.selectedIndex];
            [self.childData setValue:string forKey:PROJECT];
            break;
        case GENDER_TAG:
            string = [self.pickerData objectAtIndex:self.selectedIndex];
            [self.childData setValue:string forKey:GENDER];
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

- (void)showPicker
{
    //Create picker..
    self.projectPicker = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, 0, 0)];
    self.projectPicker.showsSelectionIndicator = YES;
    self.projectPicker.dataSource = self;
    self.projectPicker.delegate = self;
    
    if ([self.selectedCellTitle isEqualToString:@"Project"]) {
        
        //Setup projects array..
        NSArray *array = [[NSArray alloc] initWithArray:[self.database getAllProjects]];
        self.pickerData = [[NSMutableArray alloc] init];
        for (Project *project in array) {
            [self.pickerData addObject:project.name];
        }
        
        //Sort projects array..
        [self.pickerData sortUsingSelector:@selector(compare:)];
        
        //Add buttons to toolbar..
        [self addToolBarWithButtonsAndTitle:@"Projects" andTag:PROJECT_TAG];

    } else if ([self.selectedCellTitle isEqualToString:@"Gender"]) {
        
        //Setup gender array..
        self.pickerData = [[NSMutableArray alloc] initWithObjects:@"Female", @"Male", nil];
        
        //Add buttons to toolbar..
        [self addToolBarWithButtonsAndTitle:@"Gender" andTag:GENDER_TAG];
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
    self.selectedIndex = row;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 8;
    } else if (section == 2) {
        return [self.guardians count] + 1;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    switch ([indexPath section]) {
        case 0:
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
                    cell.textLabel.text = @"Gender";
                    cell.detailTextLabel.text = [self.childData valueForKey:GENDER];
                    break;
                case 3:
                    cell.textLabel.text = @"Date of Birth";
                    cell.detailTextLabel.text = [self.childData valueForKey:DOB];
                    break;
                case 4:
                    cell.textLabel.text = @"Address";
                    cell.detailTextLabel.text = [self.childData valueForKey:ADDRESS];
                    break;
                case 5:
                    cell.textLabel.text = @"City";
                    cell.detailTextLabel.text = [self.childData valueForKey:CITY];
                    break;
                case 6:
                    cell.textLabel.text = @"Country";
                    cell.detailTextLabel.text = [self.childData valueForKey:COUNTRY];
                    break;
                case 7:
                    cell.textLabel.text = @"Project";
                    cell.detailTextLabel.text = [self.childData valueForKey:PROJECT];
                    break;
            }
            break;
        case 1:
            cell.textLabel.text = @"Health";
            cell.detailTextLabel.text = nil;
            break;
    }
    if ([indexPath section] == 2) {
        
        //If row is less then number of guardians, set cell row text to guardian first/last name
        if ([indexPath row] < [self.guardians count]) {
            NSMutableDictionary *guardian = [self.guardians objectAtIndex:[indexPath row]];
            cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", [guardian valueForKey:FIRST_NAME], [guardian valueForKey:LAST_NAME]];
        } else {
            cell.textLabel.text = @"Add Guardian";
        }
        cell.detailTextLabel.text = nil;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"General Child Info";
            break;
        case 2:
            return @"Guardians";
            break;
        default:
            return @"";
            break;
    }
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] == 2) {
        if ([indexPath row] < [self.guardians count])
            return YES;
    }
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.guardians removeObjectAtIndex:[indexPath row]];
    }
    [self.tableView deleteRowsAtIndexPaths:[[NSArray alloc] initWithObjects:indexPath, nil] withRowAnimation:UITableViewRowAnimationRight];
    NSLog(@"%d", [self.guardians count]);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([indexPath section]) {
        case 0:
            switch ([indexPath row]) {
                case 0:
                    self.selectedCellTitle = @"First Name";
                    self.selectedCellIdentifier = FIRST_NAME;
                    [self performSegueWithIdentifier:@"InputData" sender:self];
                    break;
                case 1:
                    self.selectedCellTitle = @"Last Name";
                    self.selectedCellIdentifier = LAST_NAME;
                    [self performSegueWithIdentifier:@"InputData" sender:self];
                    break;
                case 2:
                    self.selectedCellTitle = @"Gender";
                    [self showPicker];
                    break;
                case 3:
                    self.selectedCellTitle = @"Date of Birth";
                    [self showDatePicker];
                    break;
                case 4:
                    self.selectedCellTitle = @"Address";
                    self.selectedCellIdentifier = ADDRESS;
                    [self performSegueWithIdentifier:@"InputData" sender:self];
                    break;
                case 5:
                    self.selectedCellTitle = @"City";
                    self.selectedCellIdentifier = CITY;
                    [self performSegueWithIdentifier:@"InputData" sender:self];
                    break;
                case 6:
                    self.selectedCellTitle = @"Country";
                    self.selectedCellIdentifier = COUNTRY;
                    [self performSegueWithIdentifier:@"InputData" sender:self];
                    break;
                case 7:
                    self.selectedCellTitle = @"Project";
                    [self showPicker];
                    break;
            }
            break;
        case 1:
            [self performSegueWithIdentifier:@"GoToHealth" sender:self];
            break;
        case 2:
            if ([indexPath row] < [self.guardians count]) {
                self.selectedCellTitle = @"EditGuardian";
                self.selectedIndex = [indexPath row];
            }
            else
                self.selectedCellTitle = @"NewGuardian";
            [self performSegueWithIdentifier:@"GoToGuardian" sender:self];
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"InputData"]) {
        InputDataViewController *idvc = (InputDataViewController *)segue.destinationViewController;
        idvc.titleString = self.selectedCellTitle;
        idvc.dataString = [self.childData valueForKey:self.selectedCellIdentifier];
        idvc.delegate = self;
    } else if ([segue.identifier isEqualToString:@"GoToHealth"]) {
        RegisterHealthViewController *rhvc = (RegisterHealthViewController *)segue.destinationViewController;
        rhvc.healthData = [[NSMutableDictionary alloc] initWithDictionary:self.healthData];
        rhvc.delegate = self;
    } else if ([segue.identifier isEqualToString:@"GoToGuardian"]) {
        RegisterGuardianViewController *rgvc = (RegisterGuardianViewController *)segue.destinationViewController;
        rgvc.delegate = self;
        if ([self.selectedCellTitle isEqualToString:@"NewGuardian"]) {
            rgvc.guardianData = [[NSMutableDictionary alloc] init];
        } else {
            rgvc.guardianData = [[NSMutableDictionary alloc] initWithDictionary:[self.guardians objectAtIndex:self.selectedIndex]];
        }
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
    } else if ([self.selectedCellTitle isEqualToString:@"Address"]) {
        [self.childData setValue:data forKey:ADDRESS];
    } else if ([self.selectedCellTitle isEqualToString:@"City"]) {
        [self.childData setValue:data forKey:CITY];
    } else if ([self.selectedCellTitle isEqualToString:@"Country"]) {
        [self.childData setValue:data forKey:COUNTRY];
    } else if ([self.selectedCellTitle isEqualToString:@"Project"]) {
        [self.childData setValue:data forKey:PROJECT];
    }
    [[self tableView] reloadData];
}

- (void)guardianInfo:(NSMutableDictionary *)info
{
    //If new guardian, add to guardians array. Else update..
    if ([self.selectedCellTitle isEqualToString:@"NewGuardian"]) {
        if ([info valueForKey:FIRST_NAME])
            [self.guardians addObject:info];
    } else {
        [self.guardians replaceObjectAtIndex:self.selectedIndex withObject:info];
    }
    [self.tableView reloadData];
}

- (void)healthInfo:(NSMutableDictionary *)info
{
    //Set health data into healthData dictionary..
    self.healthData = [[NSMutableDictionary alloc] initWithDictionary:info];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)registerButtonPressed:(id)sender {
    
    // Store register button to display after activity indicator
    UIBarButtonItem *registerButton = self.navigationItem.rightBarButtonItem;
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc]
                                        initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    
    //Asynchronously register child.. 
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.database registerChildWithGeneralInfo:self.childData
                                         healthInfo:self.healthData
                                       andGuardians:[[NSSet alloc] initWithArray:self.guardians]];
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                        message:@"Child successfully registered"
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
        [alert show];
        self.navigationItem.rightBarButtonItem = registerButton;
        [self.database saveDatabase];
    });
}

@end