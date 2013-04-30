//
//  UpdateOptionsViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/25/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "UpdateOptionsViewController.h"
#import "InputDataViewController.h"

@interface UpdateOptionsViewController () <GetData>
@property (nonatomic, strong) NSArray *allOptions;
@end

@implementation UpdateOptionsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if ([self.titleString isEqualToString:@"Home Chores"]) {
        self.allOptions = [[NSArray alloc] initWithObjects:@"Animal Care",
                           @"Carry Water",
                           @"Child Care",
                           @"Cleaning",
                           @"Farming",
                           @"Gathering Fire Wood",
                           @"Kitchen",
                           @"Laundry",
                           @"Running Errands",
                           @"Sewing",
                           @"Other", nil];
    } else if ([self.titleString isEqualToString:@"Favorite Activities"]) {
        self.allOptions = [[NSArray alloc] initWithObjects:@"Baseball",
                           @"Cars",
                           @"Dolls",
                           @"Drawing",
                           @"Football/Soccer",
                           @"Jump Rope",
                           @"Music",
                           @"Reading",
                           @"Story Telling", nil];
    } else if ([self.titleString isEqualToString:@"Personality Traits"]) {
        self.allOptions = [[NSArray alloc] initWithObjects:@"Calm",
                           @"Energetic",
                           @"Friendly",
                           @"Happy",
                           @"Sad",
                           @"Shy",
                           @"Other", nil];
    }
    self.otherActivity = [self.selectedOptions lastObject];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.titleString;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.allOptions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    // Configure the cell...
    
    //If cell is in favorites, add check mark to cell..
    cell.textLabel.text = [self.allOptions objectAtIndex:[indexPath row]];
    if ([self.selectedOptions containsObject:[self.allOptions objectAtIndex:[indexPath row]]])
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    //If table is 'Favorite Activities' or 'Personality Traits' and its the last cell, set cell text to otherActivity..
    if (([indexPath row] == [self.allOptions count] - 1) &&
        ([self.titleString isEqualToString:@"Favorite Activities"] || [self.titleString isEqualToString:@"Personality Traits"])) {
        
        cell.detailTextLabel.text = self.otherActivity;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else
        cell.detailTextLabel.text = nil;
    
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    //If table is 'Favorite Activities' or 'Personality Traits'..
    if ([self.titleString isEqualToString:@"Favorite Activities"] || [self.titleString isEqualToString:@"Personality Traits"]) {
        
        //Reverse selection accessory if its not "other", and remove from selectedOptions..
        if ([indexPath row] != [self.allOptions count] - 1) {
            if ([cell accessoryType] == UITableViewCellAccessoryCheckmark) {
                [cell setAccessoryType:UITableViewCellAccessoryNone];
                [self.selectedOptions removeObject:cell.textLabel.text];
            } else {
                [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
                [self.selectedOptions addObject:cell.textLabel.text];
            }
        } else {
            [self performSegueWithIdentifier:@"InputData" sender:self];
        }
    } else {
        
        //Reverse selection accessory, and remove from selectedOptions..
        if ([cell accessoryType] == UITableViewCellAccessoryCheckmark) {
            [cell setAccessoryType:UITableViewCellAccessoryNone];
            [self.selectedOptions removeObject:cell.textLabel.text];
        } else {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
            [self.selectedOptions addObject:cell.textLabel.text];
        }
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"InputData"]) {
        InputDataViewController *idvc = (InputDataViewController *)segue.destinationViewController;
        idvc.titleString = @"Other";
        idvc.dataString = self.otherActivity;
        idvc.delegate = self;
    }
}

- (void)giveBackData:(NSString *)data
{
    [self dismissViewControllerAnimated:YES completion:nil];
    self.otherActivity = data;
    [self.tableView reloadData];
}

- (IBAction)doneButtonPressed:(id)sender {

    //If there is an otherActivity, add it to activities. Else add a blank activity (will be ignored when update occurs)..
    if (self.otherActivity)
        [self.selectedOptions addObject:self.otherActivity];
    else
        [self.selectedOptions addObject:@""];
    
    [self.delegate optionInfo:self.selectedOptions];
}

@end
