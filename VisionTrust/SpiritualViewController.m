//
//  SpiritualViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/27/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "SpiritualViewController.h"

@interface SpiritualViewController ()
@property (nonatomic, strong) NSMutableArray *spiritualActivities;
@end

@implementation SpiritualViewController

#define SPIRITUAL_OPTION @"Spiritual"
#define BAPTISM @"baptism"
#define SALVATION @"salvation"
#define SPIRITUAL_ACTIVITIES @"spiritualActivities"
#define PROGRESS @"progress"

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Get spiritual update (only if interactions is not null)..
    Update *spiritual;
    if (self.interaction) {
        for (Update *update in [self.interaction.updates allObjects]) {
            if ([update.updateDescription isEqualToString:SPIRITUAL_OPTION])
                spiritual = update;
        }
    }
    
    //Get spiritual option (only if spiritual update is not null)..
    UpdateOptions *spiritualOption;
    if (spiritual) {
        for (UpdateOptions *option in [spiritual.hasUpdateOptions allObjects]) {
            if ([option.updateOptionDescription isEqualToString:SPIRITUAL_OPTION])
                spiritualOption = option;
        }
    }
    
    //Get all category description strings and insert into spiritualActivities (only if spiritualOption is not null)..
    self.spiritualActivities = [[NSMutableArray alloc] init];
    if (spiritualOption) {
        NSArray *categories = [[NSArray alloc] initWithArray:[spiritualOption.hasCategories allObjects]];
        for (OptionCategories *category in categories) {
            [self.spiritualActivities addObject:category.categoryDescription];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return 3;
    else if ([self.spiritualActivities count] > 0)
        return [self.spiritualActivities count];
    else
        return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return @"General";
    return @"Spiritual Activities";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    // Configure the cell...
    //If a spiritual category is null, output 'No record'..
    switch ([indexPath section]) {
        case 0:
            switch ([indexPath row]) {
                case 0:
                    cell.textLabel.text = @"Baptismal Status";
                    if (self.interaction.isBaptized)
                        cell.detailTextLabel.text = self.interaction.isBaptized;
                    else
                        cell.detailTextLabel.text = @"No record";
                    break;
                case 1:
                    cell.textLabel.text = @"Salvation Status";
                    if (self.interaction.isSaved)
                        cell.detailTextLabel.text = self.interaction.isSaved;
                    else
                        cell.detailTextLabel.text = @"No record";
                    break;
                case 2:
                    cell.textLabel.text = @"Spiritual Progress";
                    if (self.interaction.spiritualProgress)
                        cell.detailTextLabel.text = self.interaction.spiritualProgress;
                    else
                        cell.detailTextLabel.text = @"No record";
                    break;
            }
            break;
        case 1:
            if ([self.spiritualActivities count] > 0) {
                cell.textLabel.text = [self.spiritualActivities objectAtIndex:[indexPath row]];
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            else
                cell.textLabel.text = @"No spiritual activities listed";
            cell.detailTextLabel.text = nil;
            break;
    }
    return cell;
}

//Only for exiting to ViewUpdate controller..
- (IBAction)doneButtonPressed:(id)sender {
    [self.delegate exitCategory];
}

@end
