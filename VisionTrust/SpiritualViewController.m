//
//  SpiritualViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/27/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "SpiritualViewController.h"

@interface SpiritualViewController ()
@property (nonatomic, strong) Interactions *latestInteraction;
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
    
    //Get latest interaction..
    NSArray *interactions = [self.child.interactions allObjects];
    for (Interactions *i in interactions) {
        if (([self.latestInteraction.interactionDate compare:i.interactionDate] == NSOrderedAscending) || !self.latestInteraction) {
            self.latestInteraction = i;
        }
    }
    
    //Get spiritual option..
    UpdateOptions *spiritual;
    for (UpdateOptions *option in [self.latestInteraction.update.hasUpdateOptions allObjects]) {
        if ([option.updateOptionDescription isEqualToString:SPIRITUAL_OPTION])
            spiritual = option;
    }
    
    //Get all category description strings and insert into spiritualActivities..
    self.spiritualActivities = [[NSMutableArray alloc] init];
    NSArray *categories = [[NSArray alloc] initWithArray:[spiritual.hasCategories allObjects]];
    for (OptionCategories *category in categories) {
        [self.spiritualActivities addObject:category.categoryDescription];
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
    return [self.spiritualActivities count];
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
    switch ([indexPath section]) {
        case 0:
            switch ([indexPath row]) {
                case 0:
                    cell.textLabel.text = @"Baptismal Status";
                    cell.detailTextLabel.text = self.latestInteraction.isBaptized;
                    break;
                case 1:
                    cell.textLabel.text = @"Salvation Status";
                    cell.detailTextLabel.text = self.latestInteraction.isSaved;
                    break;
                case 2:
                    cell.textLabel.text = @"Spiritual Progress";
                    cell.detailTextLabel.text = self.latestInteraction.spiritualProgress;
                    break;
            }
            break;
        case 1:
            cell.textLabel.text = [self.spiritualActivities objectAtIndex:[indexPath row]];
            cell.detailTextLabel.text = nil;
            break;
    }
    return cell;
}

@end
