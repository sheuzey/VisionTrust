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

#define FNAME @"First Name"
#define LNAME @"Last Name"
#define RELATION @"Relation"
#define OCCUPATION @"Occupation"
#define STATUS @"Status"

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.guardianData = [[NSMutableDictionary alloc] init];
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
            cell.textLabel.text = FNAME;
            cell.detailTextLabel.text = [self.guardianData valueForKey:FNAME];
            break;
        case 1:
            cell.textLabel.text = LNAME;
            cell.detailTextLabel.text = [self.guardianData valueForKey:LNAME];
            break;
        case 2:
            cell.textLabel.text = RELATION;
            cell.detailTextLabel.text = [self.guardianData valueForKey:RELATION];
            break;
        case 3:
            cell.textLabel.text = OCCUPATION;
            cell.detailTextLabel.text = [self.guardianData valueForKey:OCCUPATION];
            break;
        case 4:
            cell.textLabel.text = STATUS;
            cell.detailTextLabel.text = [self.guardianData valueForKey:STATUS];
            break;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([indexPath row]) {
        case 0:
            self.selectedCellTitle = FNAME;
            break;
        case 1:
            self.selectedCellTitle = LNAME;
            break;
        case 2:
            self.selectedCellTitle = RELATION;
            break;
        case 3:
            self.selectedCellTitle = OCCUPATION;
            break;
        case 4:
            self.selectedCellTitle = STATUS;
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

- (void)giveBackData:(id)data
{
    if ([self.selectedCellTitle isEqualToString:FNAME]) {
        [self.guardianData setValue:data forKey:FNAME];
    } else if ([self.selectedCellTitle isEqualToString:LNAME]) {
        [self.guardianData setValue:data forKey:LNAME];
    } else if ([self.selectedCellTitle isEqualToString:RELATION]) {
        [self.guardianData setValue:data forKey:RELATION];
    } else if ([self.selectedCellTitle isEqualToString:OCCUPATION]) {
        [self.guardianData setValue:data forKey:OCCUPATION];
    } else if ([self.selectedCellTitle isEqualToString:STATUS]) {
        [self.guardianData setValue:data forKey:STATUS];
    }
    [[self tableView] reloadData];
}

@end
