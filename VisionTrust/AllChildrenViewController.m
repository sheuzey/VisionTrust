//
//  OtherChildrenViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/20/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "AllChildrenViewController.h"
#import "PersonalViewController.h"

@interface AllChildrenViewController ()
@property (nonatomic, strong) Child *selectedChild;
@end

@implementation AllChildrenViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = [NSString stringWithFormat:@"%@ %@", self.guardian.firstName, self.guardian.lastName];
    
    //(For use in viewing update)
    //Done Button..
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed)];
    
    //Title Label..
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 30)];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setText:[NSString stringWithFormat:@"%@ %@", self.guardian.firstName, self.guardian.lastName]];
    UIBarButtonItem *titleButton = [[UIBarButtonItem alloc] initWithCustomView:titleLabel];
    
    //Add to array, then add to toolbar..
    [barItems addObject:doneButton];
    [barItems addObject:titleButton];
    [self.navBar setItems:barItems animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.guardian.guardianOf count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"All Children";
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Child *child = [[self.guardian.guardianOf allObjects] objectAtIndex:[indexPath row]];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@", child.firstName, child.lastName];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedChild = [[self.guardian.guardianOf allObjects] objectAtIndex:[indexPath row]];
    [self performSegueWithIdentifier:@"GoToPersonal" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"GoToPersonal"]) {
        PersonalViewController *pvc = (PersonalViewController *)segue.destinationViewController;
        pvc.child = self.selectedChild;
    }
}

//Only for exiting to ViewUpdate controller..
- (void)doneButtonPressed
{
    [self.delegate exitAllChildren];
}

@end
