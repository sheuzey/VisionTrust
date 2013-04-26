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
@end

@implementation UpdateListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.interactions = [[NSArray alloc] initWithArray:[self.child.interactions allObjects]];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.child.interactions count];
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
    
    switch ([indexPath row]) {
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
        
    } else if ([segue.identifier isEqualToString:@"ViewUpdate"]) {
        UpdateViewController *uvc = (UpdateViewController *)segue.destinationViewController;
        uvc.child = self.child;
    }
}
- (IBAction)addButtonPressed:(id)sender {
    [self performSegueWithIdentifier:@"GoToUpdate" sender:self];
}

@end
