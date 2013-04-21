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
    
    self.title = [NSString stringWithFormat:@"%@ %@", self.child.firstName, self.child.lastName];
    [self.childImageView setImage:[UIImage imageNamed:self.child.pictureURL]];
    self.childImageView.layer.masksToBounds = YES;
    self.childImageView.layer.cornerRadius = 5.0;
    self.tableView.backgroundView = nil;
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
                    cell.textLabel.text = @"City";
                    cell.detailTextLabel.text = self.child.city;
                    break;
                case 4:
                    cell.textLabel.text = @"Project";
                    cell.detailTextLabel.text = self.child.isPartOfProject.name;
                    break;
            }
            cell.accessoryType = UITableViewCellAccessoryNone;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            break;
        case 1:
            cell.textLabel.text = @"Info";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = nil;
            break;
        case 2:

            cell.textLabel.text = @"Info";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = nil;
            break;
        case 3:
            cell.textLabel.text = @"Info";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = nil;
            break;
        case 4:
            cell.textLabel.text = @"Info";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = nil;
            break;
        case 5:
            cell.textLabel.text = @"Info";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = nil;
            break;
            
    }
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
        gvc.child = self.child;
    }
}


@end
