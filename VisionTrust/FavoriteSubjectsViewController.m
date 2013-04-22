//
//  FavoriteSubjectsViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/21/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "FavoriteSubjectsViewController.h"
#import "InputDataViewController.h"

@interface FavoriteSubjectsViewController () <GetData>
@property (nonatomic, strong) NSArray *subjects;
@property (nonatomic, strong) NSString *otherSubject;
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
        cell.textLabel.text = self.otherSubject;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    //Reverse selection accessory if its in the first section
    if ([indexPath section] == 0) {
        if ([cell accessoryType] == UITableViewCellAccessoryCheckmark) {
            [cell setAccessoryType:UITableViewCellAccessoryNone];
        } else {
            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
        }
    } else {
        [self performSegueWithIdentifier:@"InputData" sender:self];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"InputData"]) {
        InputDataViewController *idvc = (InputDataViewController *)segue.destinationViewController;
        idvc.titleString = @"Other";
        idvc.dataString = self.otherSubject;
        idvc.delegate = self;
    }
}

- (void)giveBackData:(NSString *)data
{
    [self dismissViewControllerAnimated:YES completion:nil];
    self.otherSubject = data;
    [self.tableView reloadData];
}

- (IBAction)doneButtonePressed:(id)sender {
    
    if ([self.otherSubject length] > 0)
        [self.favoriteSubjects addObject:self.otherSubject];
    [self.delegate favoriteSubjects:self.favoriteSubjects];
}

@end
