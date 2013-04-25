//
//  PersonalViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/19/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "PersonalViewController.h"
#import "GuardianViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface PersonalViewController ()
@property (nonatomic, assign) NSInteger selectedGuardianIndex;
@end

@implementation PersonalViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Set background color..
    self.view.backgroundColor = [UIColor clearColor];
    UITableView *tv = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:tv];
    [self.view sendSubviewToBack:tv];
    
    //Setup title and picture..
    self.title = [NSString stringWithFormat:@"%@ %@", self.child.firstName, self.child.lastName];
    [self.childImageView setImage:[UIImage imageNamed:self.child.pictureURL]];
    self.childImageView.layer.masksToBounds = YES;
    self.childImageView.layer.cornerRadius = 5.0;
    self.tableView.backgroundView = nil;
    
    //Load guardians to array (for faster enumerations..
    self.guardians = [[NSArray alloc] initWithArray:[self.child.hasGuardians allObjects]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 7;
    } else if (section == 5) {
        return [self.guardians count];
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
                    cell.textLabel.text = @"Date of Birth";
                    cell.detailTextLabel.text = self.child.dob;
                    break;
                case 3:
                    cell.textLabel.text = @"Address";
                    cell.detailTextLabel.text = self.child.address;
                    break;
                case 4:
                    cell.textLabel.text = @"City";
                    cell.detailTextLabel.text = self.child.city;
                    break;
                case 5:
                    cell.textLabel.text = @"Country";
                    cell.detailTextLabel.text = self.child.country;
                    break;
                case 6:
                    cell.textLabel.text = @"Project";
                    cell.detailTextLabel.text = self.child.isPartOfProject.name;
                    break;
            }
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
        case 1:
            cell.textLabel.text = @"Academic";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = nil;
            break;
        case 2:
            cell.textLabel.text = @"Health";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = nil;
            break;
        case 3:
            cell.textLabel.text = @"Spiritual";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = nil;
            break;
        case 4:
            cell.textLabel.text = @"Home Life";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = nil;
            break;
    }
    if ([indexPath section] == 5) {
        Guardian *guardian = [self.guardians objectAtIndex:[indexPath row]];
        cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", guardian.firstName, guardian.lastName];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.text = nil;
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"General Info";
            break;
        case 5:
            return @"Guardians";
            break;
        default:
            return @"";
            break;
    }
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
                self.selectedGuardianIndex = [indexPath row];
                [self performSegueWithIdentifier:@"GoToGuardian" sender:self];
                break;
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"GoToAcademic"]) {
        
    } else if ([segue.identifier isEqualToString:@"GoToHealth"]) {
        
    } else if ([segue.identifier isEqualToString:@"GoToSpiritual"]) {
        
    } else if ([segue.identifier isEqualToString:@"GoToHomeLife"]) {
        
    } else if ([segue.identifier isEqualToString:@"GoToGuardian"]) {
        GuardianViewController *gvc = (GuardianViewController *)segue.destinationViewController;
        gvc.guardian = [self.guardians objectAtIndex:self.selectedGuardianIndex];
        gvc.child = self.child;
    }
}


@end
