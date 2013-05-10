//
//  UpdateListViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/25/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "UpdateListViewController.h"
#import "UpdateViewController.h"
#import "ViewUpdateViewController.h"

@interface UpdateListViewController () <ExitUpdateProtocol, ExitViewUpateProtocol>
@property (nonatomic, assign) NSInteger selectedInteractionIndex;
@property (nonatomic, strong) NSMutableArray *interactions;
@end

@implementation UpdateListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Back Button..
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(backButtonPressed)];
    backButton.title = @"Back";
    
    //Title Label..
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 30)];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setText:[NSString stringWithFormat:@"%@ %@", self.child.firstName, self.child.lastName]];
    UIBarButtonItem *titleButton = [[UIBarButtonItem alloc] initWithCustomView:titleLabel];
    
    //Add Button..
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addButtonPressed)];
    addButton.style = UIBarButtonItemStyleBordered;
    
    //Add to array, then add to toolbar..
    [barItems addObject:backButton];
    [barItems addObject:titleButton];
    [barItems addObject:addButton];
    [self.toolBar setItems:barItems animated:YES];
}

- (void)viewWillAppear:(BOOL)animated
{
    //Sort interactions by date..
    self.interactions = [[NSMutableArray alloc] initWithArray:[self.child.interactions allObjects]];
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"interactionDate" ascending:YES];
    [self.interactions sortUsingDescriptors:[NSArray arrayWithObject:descriptor]];
    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.interactions count];
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
        uvc.delegate = self;
    }
    if ([segue.identifier isEqualToString:@"ViewUpdate"]) {
        ViewUpdateViewController *vuvc = (ViewUpdateViewController *)segue.destinationViewController;
        vuvc.child = self.child;
        
        //Get date of interaction
        Interactions *selectedInteraction = [self.interactions objectAtIndex:self.selectedInteractionIndex];
        vuvc.date = selectedInteraction.interactionDate;
        vuvc.delegate = self;
    }
}

- (void)exitUpdate
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)exitViewUpdate
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addButtonPressed
{
    [self performSegueWithIdentifier:@"GoToUpdate" sender:self];
}

- (void)backButtonPressed
{
    [self.delegate exitUpdateList];
}


@end
