//
//  PersonalViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/19/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "PersonalViewController.h"
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
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    switch ([indexPath section]) {
        case 0:
            switch ([indexPath row]) {
                case 0:
                    cell.textLabel.text = @"First Name";
                    cell.detailTextLabel.text = self.child.firstName;
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    break;
                case 1:
                    cell.textLabel.text = @"Last Name";
                    cell.detailTextLabel.text = self.child.lastName;
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    break;
                case 2:
                    cell.textLabel.text = @"Date of Birth";
                    cell.detailTextLabel.text = self.child.dob;
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    break;
                case 3:
                    cell.textLabel.text = @"City";
                    cell.detailTextLabel.text = self.child.city;
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    break;
                case 4:
                    cell.textLabel.text = @"Project";
                    cell.detailTextLabel.text = self.child.isPartOfProject.name;
                    cell.accessoryType = UITableViewCellAccessoryNone;
                    break;
            }
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
            return @"Guardian Info";
            break;
        default:
            return @"";
            break;
    }
}


@end
