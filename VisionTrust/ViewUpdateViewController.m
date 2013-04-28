//
//  ViewUpdateViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/28/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "ViewUpdateViewController.h"
#import "GuardianViewController.h"
#import "HealthViewController.h"
#import "SpiritualViewController.h"
#import "AcademicViewController.h"
#import "HomeLifeViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewUpdateViewController () <ExitCategory>
@property (nonatomic, strong) Interactions *selectedInteraction;
@end

@implementation ViewUpdateViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Done Button..
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(backButtonPressed)];
    
    //Title Label..
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 30)];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setText:[NSString stringWithFormat:@"%@ %@", self.child.firstName, self.child.lastName]];
    UIBarButtonItem *titleButton = [[UIBarButtonItem alloc] initWithCustomView:titleLabel];
    
    //Add to array, then add to toolbar..
    [barItems addObject:doneButton];
    [barItems addObject:titleButton];
    [self.navBar setItems:barItems animated:YES];
    
    //Set selectedInteraction..
    for (Interactions *i in [self.child.interactions allObjects]) {
        if ([i.interactionDate compare:self.date] == NSOrderedSame)
            self.selectedInteraction = i;
    }
    
    self.child = [super child];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [super tableView:tableView numberOfRowsInSection:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [super numberOfSectionsInTableView:tableView];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [super tableView:tableView titleForHeaderInSection:section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"GoToAcademic"]) {
        AcademicViewController *avc = (AcademicViewController *)segue.destinationViewController;
        avc.interaction = self.selectedInteraction;
        avc.delegate = self;
    } else if ([segue.identifier isEqualToString:@"GoToHealth"]) {
        HealthViewController *hvc = (HealthViewController *)segue.destinationViewController;
        hvc.interaction = self.selectedInteraction;
        hvc.delegate = self;
    } else if ([segue.identifier isEqualToString:@"GoToSpiritual"]) {
        SpiritualViewController *svc = (SpiritualViewController *)segue.destinationViewController;
        svc.interaction = self.selectedInteraction;
        svc.delegate = self;
    } else if ([segue.identifier isEqualToString:@"GoToHomeLife"]) {
        HomeLifeViewController *hlvc = (HomeLifeViewController *)segue.destinationViewController;
        hlvc.interaction = self.selectedInteraction;
        hlvc.delegate = self;
    }
}

- (void)backButtonPressed
{
    [self.delegate exitViewUpdate];
}

- (void)exitCategory
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
