//
//  RegisterGuardianViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/20/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "RegisterGuardianViewController.h"
#import "InputDataViewController.h"

@interface RegisterGuardianViewController () <GetData>
@property (nonatomic, strong) NSString *selectedCellTitle;
@property (nonatomic, strong) NSString *selectedCellIdentifier;
@property (nonatomic, strong) VisionTrustDatabase *database;
@end

@implementation RegisterGuardianViewController

#define FNAME @"firstName"
#define LNAME @"lastName"
#define OCCUPATION @"occupation"
#define STATUS @"status"

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Guardian";
    self.database = [VisionTrustDatabase vtDatabase];
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

    //If given a guardian object, use guardian's data. Else, use the guardianData dictionary..
    if (self.guardian) {
        switch ([indexPath row]) {
            case 0:
                cell.textLabel.text = @"First Name";
                cell.detailTextLabel.text = self.guardian.firstName;
                break;
            case 1:
                cell.textLabel.text = @"Last Name";
                cell.detailTextLabel.text = self.guardian.lastName;
                break;
            case 2:
                cell.textLabel.text = @"Occupation";
                cell.detailTextLabel.text = self.guardian.hasOccupationType.occupationTypeDescription;
                break;
            case 3:
                cell.textLabel.text = @"Status";
                cell.detailTextLabel.text = self.guardian.hasGuardianStatus.guardianStatusDescription;
                break;
        }  
    } else {
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
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.guardian) {
        switch ([indexPath row]) {
            case 0:
                self.selectedCellTitle = @"First Name";
                self.selectedCellIdentifier = self.guardian.firstName;
                break;
            case 1:
                self.selectedCellTitle = @"Last Name";
                self.selectedCellIdentifier = self.guardian.lastName;
                break;
            case 2:
                self.selectedCellTitle = @"Occupation";
                self.selectedCellIdentifier = self.guardian.hasOccupationType.occupationTypeDescription;
                break;
            case 3:
                self.selectedCellTitle = @"Status";
                self.selectedCellIdentifier = self.guardian.hasGuardianStatus.guardianStatusDescription;
                break;
        }
        
    } else {
        switch ([indexPath row]) {
            case 0:
                self.selectedCellTitle = @"First Name";
                self.selectedCellIdentifier = FNAME;
                break;
            case 1:
                self.selectedCellTitle = @"Last Name";
                self.selectedCellIdentifier = LNAME;
                break;
            case 2:
                self.selectedCellTitle = @"Occupation";
                self.selectedCellIdentifier = OCCUPATION;
                break;
            case 3:
                self.selectedCellTitle = @"Status";
                self.selectedCellIdentifier = STATUS;
                break;
        }
    }
    [self performSegueWithIdentifier:@"InputData" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"InputData"]) {
        InputDataViewController *idvc = (InputDataViewController *)segue.destinationViewController;
        idvc.titleString = self.selectedCellTitle;
        
        if (self.guardian)
            idvc.dataString = self.selectedCellIdentifier;
        else
            idvc.dataString = [self.guardianData valueForKey:self.selectedCellIdentifier];
        
        idvc.delegate = self;
    }
}

- (void)giveBackData:(NSString *)data
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    //If given a guardian object, update guardian's data. Else, update the guardianData dictionary..
    if (self.guardian) {
        if ([self.selectedCellTitle isEqualToString:@"First Name"]) {
            self.guardian.firstName = data;
        } else if ([self.selectedCellTitle isEqualToString:@"Last Name"]) {
            self.guardian.lastName = data;
        } else if ([self.selectedCellTitle isEqualToString:@"Occupation"]) {
            self.guardian.hasOccupationType = [self.database getOccupationTypeWithStatus:data];
        } else if ([self.selectedCellTitle isEqualToString:@"Status"]) {
            self.guardian.hasGuardianStatus = [self.database getGuardianStatusWithStatus:data];
        }
    } else {
        if ([self.selectedCellTitle isEqualToString:@"First Name"]) {
            [self.guardianData setValue:data forKey:FNAME];
        } else if ([self.selectedCellTitle isEqualToString:@"Last Name"]) {
            [self.guardianData setValue:data forKey:LNAME];
        } else if ([self.selectedCellTitle isEqualToString:@"Occupation"]) {
            [self.guardianData setValue:data forKey:OCCUPATION];
        } else if ([self.selectedCellTitle isEqualToString:@"Status"]) {
            [self.guardianData setValue:data forKey:STATUS];
        }
    }
    [[self tableView] reloadData];
}


- (IBAction)doneButtonPressed:(id)sender {
    
    if (self.guardian)
        [self.delegate giveBackGuardian:self.guardian];
    else if (self.giveBackGuardianFromData) {
        [self.delegate guardianInfo:self.guardianData];
    }
    else
        [self.delegate guardianInfo:self.guardianData];
    
}

@end
