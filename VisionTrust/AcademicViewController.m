//
//  AcademicViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/26/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "AcademicViewController.h"

@interface AcademicViewController ()
@property (nonatomic, strong) NSMutableArray *favoriteSubjects;
@property (nonatomic, strong) Interactions *latestInteraction;
@property (nonatomic, strong) UpdateOptions *academicOptions;
@end

@implementation AcademicViewController

#define ACADEMIC_OPTION @"Academic"
#define GRADE @"currentGrade"
#define DEVELOPMENT_LEVEL @"developmentLevel"
#define FAVORITE_SUBJECTS @"favoriteSubjects"

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
    
    //Get academic option..
    for (UpdateOptions *option in [self.latestInteraction.update.hasUpdateOptions allObjects]) {
        if ([option.updateOptionDescription isEqualToString:ACADEMIC_OPTION])
            self.academicOptions = option;
    }
    
    //Get all category description strings and insert into favoriteSubjects..
    self.favoriteSubjects = [[NSMutableArray alloc] init];
    NSArray *categories = [[NSArray alloc] initWithArray:[self.academicOptions.hasCategories allObjects]];
    for (OptionCategories *category in categories) {
        [self.favoriteSubjects addObject:category.categoryDescription];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return 2;
    return [self.favoriteSubjects count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return @"General Info";
    return @"Favorite Subjects";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    // Configure the cell..
    switch ([indexPath section]) {
        case 0:
            switch ([indexPath row]) {
                case 0:
                    cell.textLabel.text = @"Current Grade";
                    cell.detailTextLabel.text = self.latestInteraction.schoolGrade;
                    break;
                case 1:
                    cell.textLabel.text = @"Performance";
                    cell.detailTextLabel.text = self.latestInteraction.developmentLevel;
                    break;
            }
            break;
        case 1:
            cell.textLabel.text = [self.favoriteSubjects objectAtIndex:[indexPath row]];
            cell.detailTextLabel.text = nil;
            break;
    }
    return cell;
}

@end
