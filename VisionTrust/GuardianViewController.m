//
//  GuardianViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/20/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "GuardianViewController.h"
#import "AllChildrenViewController.h"

@interface GuardianViewController () <ExitAllChildrenProtocol>

@end

@implementation GuardianViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Guardian";
    
    //(For use in viewing update)
    //Done Button..
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed)];
    
    //Title Label..
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 30)];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setText:@"Guardian"];
    UIBarButtonItem *titleButton = [[UIBarButtonItem alloc] initWithCustomView:titleLabel];
    
    //Add to array, then add to toolbar..
    [barItems addObject:doneButton];
    [barItems addObject:titleButton];
    [self.navBar setItems:barItems animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return 4;
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return @"Info";
    return @"";
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
                    cell.detailTextLabel.text = self.guardian.firstName;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    break;
                case 1:
                    cell.textLabel.text = @"Last Name";
                    cell.detailTextLabel.text = self.guardian.lastName;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    break;
                case 2:
                    cell.textLabel.text = @"Occupation";
                    cell.detailTextLabel.text = self.guardian.hasOccupationType.occupationTypeDescription;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    break;
                case 3:
                    cell.textLabel.text = @"Status";
                    cell.detailTextLabel.text = self.guardian.hasGuardianStatus.guardianStatusDescription;
                    cell.selectionStyle = UITableViewCellSelectionStyleNone;
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    break;
            }
            break;
        default:
            cell.textLabel.text = @"All Children";
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            cell.detailTextLabel.text = nil;
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] == 1) {
        [self performSegueWithIdentifier:@"GoToOtherChildren" sender:self];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"GoToOtherChildren"]) {
        AllChildrenViewController *ocvc = (AllChildrenViewController *)segue.destinationViewController;
        ocvc.guardian = self.guardian;
        ocvc.delegate = self;
    }
}

- (void)exitAllChildren
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//Only for exiting to ViewUpdate controller..
- (void)doneButtonPressed
{
    [self.delegate exitCategory];
}

@end
