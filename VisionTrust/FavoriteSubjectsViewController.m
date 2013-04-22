//
//  FavoriteSubjectsViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/21/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "FavoriteSubjectsViewController.h"

@interface FavoriteSubjectsViewController ()
@property (nonatomic, strong) NSArray *subjects;
@end

@implementation FavoriteSubjectsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.favoriteSubjects = [[NSMutableArray alloc] init];
    self.subjects = [[NSArray alloc] initWithObjects:@"Art",
                     @"Geography",
                     @"History",
                     @"Language",
                     @"Math",
                     @"Physical Education",
                     @"Science", nil];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 0)
        return @"Favorite Subjects";
    return @"Other";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
        return [self.subjects count];
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    if ([indexPath section] == 0) {
        cell.textLabel.text = [self.subjects objectAtIndex:[indexPath row]];
    } else {
        cell.textLabel.text = @"";
    }
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    //Reverse subject existence in favoriteSubjects array..
    
    //Reverse selection accessory..
    if ([cell accessoryType] == UITableViewCellAccessoryCheckmark) {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    } else {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (IBAction)doneButtonePressed:(id)sender {
    [self.delegate favoriteSubjects:self.favoriteSubjects];
}

@end
