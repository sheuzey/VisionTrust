//
//  SearchTableViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/14/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "SearchTableViewController.h"
#import "Child.h"
#import "CustomSearchCell.h"

@interface SearchTableViewController ()
@end

@implementation SearchTableViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.title = @"Search";
    
    self.searchData = [[NSMutableArray alloc] initWithArray:self.children];
    
    NSLog(@"%d", [self.children count]);
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
    cell.fullName.text = [NSString stringWithFormat:@"%@ %@", child.firstName, child.lastName];
    cell.cityCountry.text = [NSString stringWithFormat:@"%@, %@", child.city, child.country];
    cell.project.text = @"Some project";
    [cell.contentView setBackgroundColor:[UIColor colorWithRed:226.0/255.0 green:231.0/255.0 blue:238.0/255.0 alpha:1]];
    
    return cell;
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
