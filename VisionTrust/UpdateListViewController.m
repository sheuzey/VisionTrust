//
//  UpdateListViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/25/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "UpdateListViewController.h"
#import "UpdateViewController.h"

@interface UpdateListViewController ()
@property (nonatomic, assign) NSInteger selectedInteractionIndex;
@property (nonatomic, strong) NSArray *interactions;
@property (nonatomic, strong) NSMutableArray *updates;
@end

@implementation UpdateListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = [NSString stringWithFormat:@"%@ %@", self.child.firstName, self.child.lastName];
}

- (void)viewWillAppear:(BOOL)animated
{
    self.interactions = [[NSArray alloc] initWithArray:[self.child.interactions allObjects]];
    self.updates = [[NSMutableArray alloc] init];
    for (Interactions *interaction in self.interactions) {
        if (interaction.update)
            [self.updates addObject:interaction.update];
    }
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //Since registration will have no updates, add one for registration interaction..
    return [self.updates count] + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    Interactions *interaction = [self.interactions objectAtIndex:section];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setTimeStyle:NSDateFormatterLongStyle];
    [format setDateStyle:NSDateFormatterLongStyle];
    return [format stringFromDate:interaction.interactionDate];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    switch ([indexPath section]) {
        case 0:
            cell.textLabel.text = @"Registration";
            break;
        default:
            cell.textLabel.text = @"Update";
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedInteractionIndex = [indexPath section];
    [self performSegueWithIdentifier:@"ViewUpdate" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"GoToUpdate"]) {
        UpdateViewController *uvc = (UpdateViewController *)segue.destinationViewController;
        uvc.child = self.child;
    }
    if ([segue.identifier isEqualToString:@"ViewUpdate"]) {
        
    }
}
- (IBAction)addButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"GoToUpdate" sender:self];
}

@end
