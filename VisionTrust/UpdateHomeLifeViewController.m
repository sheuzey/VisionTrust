//
//  UpdateHomeLifeViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/25/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "UpdateHomeLifeViewController.h"
#import "UpdateOptionsViewController.h"
#import "InputDataViewController.h"

@interface UpdateHomeLifeViewController () <UpdateOptionProtocol, GetData>
@property (nonatomic, strong) NSArray *allOptions;
@property (nonatomic, assign) NSInteger selectedTableIndex;
@property (nonatomic, strong) NSString *additionalComments;
@end

@implementation UpdateHomeLifeViewController

#define FAVORITE_ACTIVITIES @"favoriteActivities"
#define HOME_CHORES @"homeChores"
#define PERSONALITY @"personalityTraits"
#define ADDITIONAL_COMMENTS @"additionalComments"

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.additionalComments = [self.homeData valueForKey:ADDITIONAL_COMMENTS];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return 3;
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    // Configure the cell...
    switch ([indexPath section]) {
        case 0:
            switch ([indexPath row]) {
                case 0:
                    cell.textLabel.text = @"Favorite Activities";
                    break;
                case 1:
                    cell.textLabel.text = @"Home Chores";
                    break;
                case 2:
                    cell.textLabel.text = @"Personality Traits";
                    break;
            }
            cell.detailTextLabel.text = nil;
            break;
        case 1:
            cell.textLabel.text = @"Additional Comments";
            cell.detailTextLabel.text = self.additionalComments;
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedTableIndex = [indexPath row];
    if ([indexPath section] == 0)
        [self performSegueWithIdentifier:@"GoToOptions" sender:self];
    else
        [self performSegueWithIdentifier:@"InputData" sender:self];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"GoToOptions"]) {
        UpdateOptionsViewController *uovc = (UpdateOptionsViewController *)segue.destinationViewController;
        switch (self.selectedTableIndex) {
            case 0:
                uovc.titleString = @"Favorite Activities";
                uovc.selectedOptions = [[NSMutableArray alloc] initWithArray:[self.homeData valueForKey:FAVORITE_ACTIVITIES]];
                break;
            case 1:
                uovc.titleString = @"Home Chores";
                uovc.selectedOptions = [[NSMutableArray alloc] initWithArray:[self.homeData valueForKey:HOME_CHORES]];
                break;
            case 2:
                uovc.titleString = @"Personality Traits";
                uovc.selectedOptions = [[NSMutableArray alloc] initWithArray:[self.homeData valueForKey:PERSONALITY]];
                break;
        }
        uovc.delegate = self;
    } else if ([segue.identifier isEqualToString:@"InputData"]) {
        InputDataViewController *idvc = (InputDataViewController *)segue.destinationViewController;
        idvc.titleString = @"Additional Comments";
        idvc.dataString = self.additionalComments;
        idvc.delegate = self;
    }
}

- (void)giveBackData:(NSString *)data
{
    [self dismissViewControllerAnimated:YES completion:nil];
    self.additionalComments = data;
    [self.tableView reloadData];
}

- (void)optionInfo:(NSMutableArray *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    switch (self.selectedTableIndex) {
        case 0:
            [self.homeData setValue:info forKey:FAVORITE_ACTIVITIES];
            break;
        case 1:
            [self.homeData setValue:info forKey:HOME_CHORES];
            break;
        case 2:
            [self.homeData setValue:info forKey:PERSONALITY];
            break;
    }
}

- (IBAction)doneButtonPressed:(id)sender {

    [self.homeData setValue:self.additionalComments forKey:ADDITIONAL_COMMENTS];
    [self.delegate homeInfo:self.homeData];
}

@end
