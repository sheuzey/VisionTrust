//
//  UpdateViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/25/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "UpdateViewController.h"
#import "UpdateAcademicViewController.h"
#import "RegisterHealthViewController.h"
#import "RegisterGuardianViewController.h"
#import "UpdateSpiritualViewController.h"
#import "UpdateHomeLifeViewController.h"
#import "InputDataViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <QuartzCore/QuartzCore.h>

@interface UpdateViewController () <UpdateAcademicProtocol, HealthRegistrationProtocol, UpdateSpiritualProtocol, UpdateHomeProtocol, GetData, GuardianRegistrationProtocol, UIAlertViewDelegate, UIImagePickerControllerDelegate>
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIPickerView *projectPicker;
@property (nonatomic, strong) UIToolbar *pickerToolBar;
@property (nonatomic, strong) UIActionSheet *actionSheet;
@property (nonatomic, assign) NSInteger selectedGuardianIndex;
@property (nonatomic, assign) NSInteger selectedPickerIndex;
@property (nonatomic, strong) UIPopoverController *imagePopover;
@property (nonatomic, strong) NSMutableDictionary *academicData;
@property (nonatomic, strong) NSMutableDictionary *healthData;
@property (nonatomic, strong) NSMutableDictionary *spiritualData;
@property (nonatomic, strong) NSMutableDictionary *homeData;
@property (nonatomic, strong) NSMutableDictionary *guardianData;
@property (nonatomic, strong) NSMutableArray *pickerData;
@property (nonatomic, strong) NSMutableArray *originalGuardians;
@property (nonatomic, strong) NSString *selectedCellTitle;
@property (nonatomic, strong) NSString *dataString;
@property (nonatomic, strong) NSString *updatedProjectName;
@property BOOL giveBackGuardianFromData;
@end

@implementation UpdateViewController

//For updating guardians..
#define FNAME @"firstName"
#define LNAME @"lastName"
#define OCCUPATION @"occupation"
#define STATUS @"status"

#define FAVORITE_SUBJECTS @"favoriteSubjects"
#define SPIRITUAL_ACTIVITIES @"spiritualActivities"

#define GENDER_TAG 100
#define DOB_TAG 200
#define PROJECT_TAG 300
#define STATUS_TAG 400

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.database = [VisionTrustDatabase vtDatabase];
    
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
    self.childImageView.layer.cornerRadius = 5.0;
    self.childImageView.layer.borderWidth = 2.5;
    
    //Setup title and picture..
    self.title = [NSString stringWithFormat:@"%@ %@", self.child.firstName, self.child.lastName];
    self.tableView.backgroundView = nil;
    
    //Create actionSheet, toolBar, datePicker and projectPicker..
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    [self.actionSheet setActionSheetStyle:UIActionSheetStyleBlackOpaque];
    
    self.pickerToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
    [self.pickerToolBar setBarStyle:UIBarStyleBlack];
    
    self.datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 40, 0, 0)];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    
    //Convert all guardian data into dictionaries and add to array..
    self.guardians = [[NSMutableArray alloc] init];
    for (Guardian *g in [self.child.hasGuardians allObjects]) {
        [self.guardians addObject:[[NSMutableDictionary alloc] initWithObjectsAndKeys:g.firstName, FNAME,
                                  g.lastName, LNAME,
                                  g.hasOccupationType.occupationTypeDescription, OCCUPATION,
                                  g.hasGuardianStatus.guardianStatusDescription, STATUS, nil]];
    }
}

- (void)cancelButtonPressed
{
    [self.actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)doneButtonPressed
{
    UIBarButtonItem *item = [self.pickerToolBar.items lastObject];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    switch (item.tag) {
        case DOB_TAG:
            [df setDateFormat:@"MM/dd/yyyy"];
            self.child.dob = [df stringFromDate:self.datePicker.date];
            break;
        case PROJECT_TAG:
            self.updatedProjectName = [self.pickerData objectAtIndex:self.selectedPickerIndex];
            break;
        case GENDER_TAG:
            self.child.gender = [self.pickerData objectAtIndex:self.selectedPickerIndex];
            break;
        case STATUS_TAG:
            self.child.status = [self.pickerData objectAtIndex:self.selectedPickerIndex];
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
    } else if ([self.selectedCellTitle isEqualToString:@"Status"]) {

        //Setup status array..
        self.pickerData = [[NSMutableArray alloc] initWithObjects:@"Active", @"Inactive", nil];
        
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
    //self.child.pictureData = UIImagePNGRepresentation(self.childImageView.image);
    
    //Remove label..
    for (UIView *view in self.childImageView.subviews) {
        if (view.tag == 100)
            [view removeFromSuperview];
    }
    [self dismissImagePicker];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 9;
    } else if (section == 5) {
        return [self.guardians count] + 1;
    }
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 6;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] == 5) {
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

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"General Child Info";
            break;
        case 5:
            return @"Guardians";
            break;
        default:
            return nil;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    //Configure...
    switch ([indexPath section]) {
        case 0:
            switch ([indexPath row]) {
                case 0:
                    cell.textLabel.text = @"First Name";
                    cell.detailTextLabel.text = self.child.firstName;
                    break;
                case 1:
                    cell.textLabel.text = @"Last Name";
                    cell.detailTextLabel.text = self.child.lastName;
                    break;
                case 2:
                    cell.textLabel.text = @"Gender";
                    cell.detailTextLabel.text = self.child.gender;
                    break;
                case 3:
                    cell.textLabel.text = @"Date of Birth";
                    cell.detailTextLabel.text = self.child.dob;
                    break;
                case 4:
                    cell.textLabel.text = @"Address";
                    cell.detailTextLabel.text = self.child.address;
                    break;
                case 5:
                    cell.textLabel.text = @"City";
                    cell.detailTextLabel.text = self.child.city;
                    break;
                case 6:
                    cell.textLabel.text = @"Country";
                    cell.detailTextLabel.text = self.child.country;
                    break;
                case 7:
                    cell.textLabel.text = @"Project";
                    if ([self.updatedProjectName length] > 0)
                        cell.detailTextLabel.text = self.updatedProjectName;
                    else
                        cell.detailTextLabel.text = self.child.isPartOfProject.name;
                    break;
                case 8:
                    cell.textLabel.text = @"Status";
                    cell.detailTextLabel.text = self.child.status;
                    break;
            }
            cell.accessoryType = UITableViewCellAccessoryNone;
            break;
        case 1:
            cell.textLabel.text = @"Academic";
            cell.detailTextLabel.text = nil;
            if (self.academicData)
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            break;
        case 2:
            cell.textLabel.text = @"Health";
            cell.detailTextLabel.text = nil;
            if (self.healthData)
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            break;
        case 3:
            cell.textLabel.text = @"Spiritual";
            cell.detailTextLabel.text = nil;
            if (self.spiritualData)
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            break;
        case 4:
            cell.textLabel.text = @"Home Life";
            cell.detailTextLabel.text = nil;
            if (self.homeData)
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            break;
        case 5:
            
            //If row is less then number of guardians, set cell row text to guardian first/last name
            if ([indexPath row] < [self.guardians count]) {
                NSMutableDictionary *d = [self.guardians objectAtIndex:[indexPath row]];
                cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", [d valueForKey:FNAME], [d valueForKey:LNAME]];
            } else {
                cell.textLabel.text = @"Add Guardian";
            }
            cell.detailTextLabel.text = nil;
            cell.accessoryType = UITableViewCellAccessoryNone;
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([indexPath section]) {
        case 0:
            switch ([indexPath row]) {
                case 0:
                    self.selectedCellTitle = @"First Name";
                    self.dataString = self.child.firstName;
                    [self performSegueWithIdentifier:@"InputData" sender:self];
                    break;
                case 1:
                    self.selectedCellTitle = @"Last Name";
                    self.dataString = self.child.lastName;
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
                    self.dataString = self.child.address;
                    [self performSegueWithIdentifier:@"InputData" sender:self];
                    break;
                case 5:
                    self.selectedCellTitle = @"City";
                    self.dataString = self.child.city;
                    [self performSegueWithIdentifier:@"InputData" sender:self];
                    break;
                case 6:
                    self.selectedCellTitle = @"Country";
                    self.dataString = self.child.country;
                    [self performSegueWithIdentifier:@"InputData" sender:self];
                    break;
                case 7:
                    self.selectedCellTitle = @"Project";
                    [self showPicker];
                    break;
                case 8:
                    self.selectedCellTitle = @"Status";
                    [self showPicker];
                    break;
            }
            break;
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
            if ([indexPath row] < [self.guardians count]) {
                self.selectedCellTitle = @"EditGuardian";
                self.selectedGuardianIndex = [indexPath row];
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
    if ([segue.identifier isEqualToString:@"InputData"]) {
        InputDataViewController *idvc = (InputDataViewController *)segue.destinationViewController;
        idvc.titleString = self.selectedCellTitle;
        idvc.dataString = self.dataString;
        idvc.delegate = self;
    } else if ([segue.identifier isEqualToString:@"GoToAcademic"]) {
        UpdateAcademicViewController *uavc = (UpdateAcademicViewController *)segue.destinationViewController;
        uavc.academicData = [[NSMutableDictionary alloc] initWithDictionary:self.academicData];
        uavc.delegate = self;
    } else if ([segue.identifier isEqualToString:@"GoToHealth"]) {
        RegisterHealthViewController *rhvc = (RegisterHealthViewController *)segue.destinationViewController;
        rhvc.healthData = [[NSMutableDictionary alloc] initWithDictionary:self.healthData];
        rhvc.delegate = self;
    } else if ([segue.identifier isEqualToString:@"GoToSpiritual"]) {
        UpdateSpiritualViewController *usvc = (UpdateSpiritualViewController *)segue.destinationViewController;
        usvc.spiritualData = [[NSMutableDictionary alloc] initWithDictionary:self.spiritualData];
        usvc.delegate = self;
    } else if ([segue.identifier isEqualToString:@"GoToHomeLife"]) {
        UpdateHomeLifeViewController *uhlvc = (UpdateHomeLifeViewController *)segue.destinationViewController;
        uhlvc.homeData = [[NSMutableDictionary alloc] initWithDictionary:self.homeData];
        uhlvc.delegate = self;
    } else if ([segue.identifier isEqualToString:@"GoToGuardian"]) {
        RegisterGuardianViewController *rgvc = (RegisterGuardianViewController *)segue.destinationViewController;
        rgvc.delegate = self;
        if ([self.selectedCellTitle isEqualToString:@"NewGuardian"]) {
            rgvc.guardianData = [[NSMutableDictionary alloc] init];
        } else {
            rgvc.guardianData = [[NSMutableDictionary alloc] initWithDictionary:[self.guardians objectAtIndex:self.selectedGuardianIndex]];
        }
    }
}

- (void)academicInfo:(NSMutableDictionary *)info
{
    self.academicData = [[NSMutableDictionary alloc] initWithDictionary:info];
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)healthInfo:(NSMutableDictionary *)info
{
    self.healthData = [[NSMutableDictionary alloc] initWithDictionary:info];
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)spiritualInfo:(NSMutableDictionary *)info
{
    self.spiritualData = [[NSMutableDictionary alloc] initWithDictionary:info];
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)homeInfo:(NSMutableDictionary *)info
{
    self.homeData = [[NSMutableDictionary alloc] initWithDictionary:info];
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)guardianInfo:(NSMutableDictionary *)info
{
    //If new guardian, add to guardians array. Else update..
    if ([self.selectedCellTitle isEqualToString:@"NewGuardian"]) {
        if ([info valueForKey:FNAME])
            [self.guardians addObject:info];
    } else {
        [self.guardians replaceObjectAtIndex:self.selectedGuardianIndex withObject:info];
    }
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.delegate exitUpdate];
}

- (IBAction)updateButtonPressed:(id)sender {
    
    // Store register button to display after activity indicator
    UIBarButtonItem *registerButton = self.navigationItem.rightBarButtonItem;
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc]
                                        initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    
    //Asynchronously update child (first update image)..
    self.child.pictureData = UIImagePNGRepresentation(self.childImageView.image);
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //Call update method..
        [self.database updateChild:self.child
                     withGuardians:self.guardians
               withUpdatdedProject:self.updatedProjectName
                  WithAcademicData:self.academicData
                        healthData:self.healthData
                     spiritualData:self.spiritualData
                       andHomeData:self.homeData];
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                        message:@"Update complete"
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
        [alert show];
        self.navigationItem.rightBarButtonItem = registerButton;
    });
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self.delegate exitUpdate];
}

- (void)giveBackData:(NSString *)data
{
    //Update child data..
    [self dismissViewControllerAnimated:YES completion:nil];
    if ([self.selectedCellTitle isEqualToString:@"First Name"]) {
        self.child.firstName = data;
    } else if ([self.selectedCellTitle isEqualToString:@"Last Name"]) {
        self.child.lastName = data;
    } else if ([self.selectedCellTitle isEqualToString:@"Address"]) {
        self.child.address = data;
    } else if ([self.selectedCellTitle isEqualToString:@"City"]) {
        self.child.city = data;
    } else if ([self.selectedCellTitle isEqualToString:@"Country"]) {
        self.child.country = data;
    }
    
    [[self tableView] reloadData];
}

@end
