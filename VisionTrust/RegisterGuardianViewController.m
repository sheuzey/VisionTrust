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
@end

@implementation RegisterGuardianViewController

#define FNAME @"firstName"
#define LNAME @"lastName"
#define RELATION @"relation"
#define OCCUPATION @"occupation"
#define STATUS @"status"

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Guardian";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
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
            cell.textLabel.text = @"Relation";
            cell.detailTextLabel.text = [self.guardianData valueForKey:RELATION];
            break;
        case 3:
            cell.textLabel.text = @"Occupation";
            cell.detailTextLabel.text = [self.guardianData valueForKey:OCCUPATION];
            break;
        case 4:
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
            break;
        case 1:
            self.selectedCellTitle = @"Last Name";
            break;
        case 2:
            self.selectedCellTitle = @"Relation";
            break;
        case 3:
            self.selectedCellTitle = @"Occupation";
            break;
        case 4:
            self.selectedCellTitle = @"Status";
            break;
    }
    [self performSegueWithIdentifier:@"InputData" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"InputData"]) {
        InputDataViewController *idvc = (InputDataViewController *)segue.destinationViewController;
        idvc.titleString = self.selectedCellTitle;
        idvc.dataString = [self.guardianData valueForKey:self.selectedCellTitle];
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
    } else if ([self.selectedCellTitle isEqualToString:@"Relation"]) {
        [self.guardianData setValue:data forKey:RELATION];
    } else if ([self.selectedCellTitle isEqualToString:@"Occupation"]) {
        [self.guardianData setValue:data forKey:OCCUPATION];
    } else if ([self.selectedCellTitle isEqualToString:@"Status"]) {
        [self.guardianData setValue:data forKey:STATUS];
    }
    [[self tableView] reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.delegate guardianInfo:self.guardianData];
}

@end
