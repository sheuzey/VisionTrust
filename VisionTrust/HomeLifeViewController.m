//
//  HomeLifeViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/27/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "HomeLifeViewController.h"

@interface HomeLifeViewController ()
@property (nonatomic, strong) NSMutableArray *favoriteActivities;
@property (nonatomic, strong) NSMutableArray *homeChores;
@property (nonatomic, strong) NSMutableArray *personalityTraits;
@property (nonatomic, strong) NSString *comments;
@end

@implementation HomeLifeViewController

#define HOMELIFE_OPTION @"Home Life"
#define FAVORITE_ACTIVITIES @"favoriteActivities"
#define HOME_CHORES @"homeChores"
#define PERSONALITY @"personalityTraits"
#define ADDITIONAL_COMMENTS @"additionalComments"

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Get homeLife update (if interaction is not null)..
    Update *homeLife;
    if (self.interaction) {
        for (Update *update in [self.interaction.updates allObjects]) {
            if ([update.updateDescription isEqualToString:HOMELIFE_OPTION])
                homeLife = update;
        }
    }
    
    if (homeLife) {
        
        //Get activities option..
        UpdateOptions *activitiesOption;
        for (UpdateOptions *option in [homeLife.hasUpdateOptions allObjects]) {
            if ([option.updateOptionDescription isEqualToString:FAVORITE_ACTIVITIES])
                activitiesOption = option;
        }
        
        //Get all category description strings in activities and insert into favoriteActivities (if activitiesOption is not null)..
        self.favoriteActivities = [[NSMutableArray alloc] init];
        if (activitiesOption) {
            for (OptionCategories *category in [[NSArray alloc] initWithArray:[activitiesOption.hasCategories allObjects]]) {
                [self.favoriteActivities addObject:category.categoryDescription];
            }
        }
        
        //Get chores option (if homeLife is not null)..
        UpdateOptions *choresOption;
        for (UpdateOptions *option in [homeLife.hasUpdateOptions allObjects]) {
            if ([option.updateOptionDescription isEqualToString:HOME_CHORES])
                choresOption = option;
        }
        
        //Get all category description strings in activities and insert into homeChores (if choresOption is not null)..
        self.homeChores = [[NSMutableArray alloc] init];
        if (choresOption) {
            for (OptionCategories *category in [[NSArray alloc] initWithArray:[choresOption.hasCategories allObjects]]) {
                [self.homeChores addObject:category.categoryDescription];
            }
        }
        
        //Get personality option (if homeLife is not null)..
        UpdateOptions *personalityOption;
        for (UpdateOptions *option in [homeLife.hasUpdateOptions allObjects]) {
            if ([option.updateOptionDescription isEqualToString:PERSONALITY])
                personalityOption = option;
        }
        
        //Get all category description strings in activities and insert into personalityTraits (if personalityOption is not null)..
        self.personalityTraits = [[NSMutableArray alloc] init];
        if (personalityOption) {
            for (OptionCategories *category in [[NSArray alloc] initWithArray:[personalityOption.hasCategories allObjects]]) {
                [self.personalityTraits addObject:category.categoryDescription];
            }
        }
        
        //Get comments option (if homeLife is not null)..
        UpdateOptions *commentOption;
        for (UpdateOptions *option in [homeLife.hasUpdateOptions allObjects]) {
            if ([option.updateOptionDescription isEqualToString:ADDITIONAL_COMMENTS])
                commentOption = option;
        }
        
        //Since there is only one object in commentOption, insert into self.comments (if commentOption is not null)..
        OptionCategories *commentCategory;
        if (commentOption) {
            commentCategory = [[[NSArray alloc] initWithArray:[commentOption.hasCategories allObjects]] lastObject];
            self.comments = commentCategory.categoryDescription;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Additional Comments";
            break;
        case 1:
            return @"Favorite Activities";
            break;
        case 2:
            return @"Home Chores";
            break;
        case 3:
            return @"Personality Traits";
            break;
        default:
            return nil;
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //Return respective counts for each array. If blank, return one row..
    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            if ([self.favoriteActivities count] > 0)
                return [self.favoriteActivities count];
            else
                return 1;
            break;
        case 2:
            if ([self.homeChores count] > 0)
                return [self.homeChores count];
            else
                return 1;
            break;
        case 3:
            if ([self.personalityTraits count] > 0)
                return [self.personalityTraits count];
            else
                return 1;
            break;
        default:
            return 1;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    // Configure the cell..
    // If each respective array contains objects, set cell title to object and add checkmark.
    // Else, set cell title to 'None' and remove checkmark..
    switch ([indexPath section]) {
        case 0:
            if ([self.comments length] > 0)
                cell.textLabel.text = self.comments;
            else
                cell.textLabel.text = @"No Comments";
            cell.accessoryType = UITableViewCellAccessoryNone;
            break;
        case 1:
            if ([self.favoriteActivities count] > 0) {
                cell.textLabel.text = [self.favoriteActivities objectAtIndex:[indexPath row]];
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            else {
                cell.textLabel.text = @"No activities listed";
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            break;
        case 2:
            if ([self.homeChores count] > 0) {
                cell.textLabel.text = [self.homeChores objectAtIndex:[indexPath row]];
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            else {
                cell.textLabel.text = @"No chores listed";
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            break;
        case 3:
            if ([self.personalityTraits count] > 0) {
                cell.textLabel.text = [self.personalityTraits objectAtIndex:[indexPath row]];
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            else {
                cell.textLabel.text = @"No traits listed";
                cell.accessoryType = UITableViewCellAccessoryNone;
            }
            break;
    }
    
    return cell;
}

//Only for exiting to ViewUpdate controller..
- (IBAction)doneButtonPressed:(id)sender {
    [self.delegate exitCategory];
}

@end
