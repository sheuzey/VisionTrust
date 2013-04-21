//
//  RegisterViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/19/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "RegisterChildViewController.h"
#import "InputDataViewController.h"

@interface RegisterChildViewController () <GetData>
@property (nonatomic, strong) NSString *selectedCellTitle;
@property (nonatomic, strong) NSMutableDictionary *childData;
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
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    switch ([indexPath row]) {
        case 0:
            self.selectedCellTitle = FIRST_NAME;
            break;
        case 1:
            self.selectedCellTitle = LAST_NAME;
            break;
        case 2:
            self.selectedCellTitle = DOB;
            break;
        case 3:
            self.selectedCellTitle = CITY;
            break;
        case 4:
            self.selectedCellTitle = PROJECT;
            break;
    }
    [self performSegueWithIdentifier:@"InputData" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"InputData"]) {
        InputDataViewController *idvc = (InputDataViewController *)segue.destinationViewController;
        idvc.titleString = self.selectedCellTitle;
        idvc.dataString = [self.childData valueForKey:self.selectedCellTitle];
        idvc.delegate = self;
    } else
        [super prepareForSegue:segue sender:sender];
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
