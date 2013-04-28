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
@end

@implementation AcademicViewController

#define ACADEMIC_OPTION @"Academic"
#define GRADE @"currentGrade"
#define DEVELOPMENT_LEVEL @"developmentLevel"
#define FAVORITE_SUBJECTS @"favoriteSubjects"

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Get academic update (only if interactions is not null)..
    Update *academic;
    if (self.interaction) {
        for (Update *update in [self.interaction.updates allObjects]) {
            if ([update.updateDescription isEqualToString:ACADEMIC_OPTION])
                academic = update;
        }
    }
    
    //Get academic option (only if academic is not null)
    //Since there is only one option for academic, retrieve last object..
    UpdateOptions *academicOption;
    if (academic)
        academicOption = [[academic.hasUpdateOptions allObjects] lastObject];
    
    //Get all category description strings and insert into favoriteSubjects (only if academicOption is not null)..
    self.favoriteSubjects = [[NSMutableArray alloc] init];
    if (academicOption) {
        NSArray *categories = [[NSArray alloc] initWithArray:[academicOption.hasCategories allObjects]];
        for (OptionCategories *category in categories) {
            [self.favoriteSubjects addObject:category.categoryDescription];
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
        return 2;
    else if ([self.favoriteSubjects count] > 0)
        return [self.favoriteSubjects count];
    else
        return 1;
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
                    if (self.interaction.schoolGrade)
                        cell.detailTextLabel.text = self.interaction.schoolGrade;
                    else
                        cell.detailTextLabel.text = @"No record";
                    break;
                case 1:
                    cell.textLabel.text = @"Performance";
                    if (self.interaction.developmentLevel)
                        cell.detailTextLabel.text = self.interaction.developmentLevel;
                    else
                        cell.detailTextLabel.text = @"No record";
                    break;
            }
            break;
        case 1:
            if ([self.favoriteSubjects count] > 0) {
                cell.textLabel.text = [self.favoriteSubjects objectAtIndex:[indexPath row]];
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            else
                cell.textLabel.text = @"No favorite subjects listed";
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
