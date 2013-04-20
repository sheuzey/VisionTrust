//
//  RegisterViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/19/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "RegisterViewController.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [super tableView].delegate = self;
    [super tableView].dataSource = self;
    [super childImageView].backgroundColor = [UIColor grayColor];
    self.title = @"Child Registration";
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
    UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [super tableView:tableView titleForHeaderInSection:section];
}

@end
