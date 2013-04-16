//
//  SearchTableViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/14/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "SearchTableViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Child.h"
#import "CustomSearchCell.h"
#import "AdvancedSearchViewController.h"

@interface SearchTableViewController () <QuitAdvancedSearchProtocol>
@end

@implementation SearchTableViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.title = @"Search";
    
    self.searchData = [[NSMutableArray alloc] initWithArray:self.children];
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    [center addObserver:self selector:@selector(keyboardWillAppear) name:UIKeyboardWillShowNotification object:nil];
    [center addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];
    
    NSLog(@"%d", [self.children count]);
}

- (void)keyboardWillAppear
{
    self.searchBar.showsCancelButton = YES;
}

- (void)keyboardWillHide
{
    self.searchBar.showsCancelButton = NO;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if([searchText length] == 0) {
        
        //Remove all objects, so as to prevent duplicate data from previous search
        [self.searchData removeAllObjects];
        [self.searchData addObjectsFromArray:self.children];
    } else {
        
        //if the search text matches anywhere within a childs full name, add to search table and reload table data
        [self.searchData removeAllObjects];
        for (Child *child in self.children) {
            NSString *nameString = [NSString stringWithFormat:@"%@ %@", child.firstName, child.lastName];
            NSRange range = [nameString rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (range.location != NSNotFound) {
                [self.searchData addObject:child];
            }
        }
    }
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    self.searchBar.text = @"";
    [self searchBar:self.searchBar textDidChange:self.searchBar.text];
    [self.searchBar resignFirstResponder];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.searchData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    CustomSearchCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure cell...
    if (!cell) {
        cell = [[CustomSearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Child *child = [self.searchData objectAtIndex:indexPath.row];
    cell.image.image = [UIImage imageNamed:child.pictureURL];
    //Round edges of picture..
    cell.image.layer.masksToBounds = YES;
    cell.image.layer.cornerRadius = 5.0;
    cell.image.layer.borderWidth = 1.0;
    cell.image.layer.borderColor = [[UIColor blackColor] CGColor];
    cell.fullName.text = [NSString stringWithFormat:@"%@ %@", child.firstName, child.lastName];
    cell.cityCountry.text = [NSString stringWithFormat:@"%@, %@", child.city, child.country];
    cell.project.text = @"Some project";
    [cell.contentView setBackgroundColor:[UIColor colorWithRed:205.0/255.0 green:201.0/255.0 blue:201.0/255.0 alpha:1]];
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"GoToAdvancedSearch"]) {
        AdvancedSearchViewController *asvc = (AdvancedSearchViewController *)segue.destinationViewController;
        asvc.delegate = self;
    }
}

- (void)exitAdvancedSearch
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    [self performSegueWithIdentifier:@"go" sender:self];
}

@end
