//
//  SearchTableViewController.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/14/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTableViewController : UITableViewController <UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSArray *dataSource;              //All data..
@property (strong, nonatomic) NSMutableArray *searchData;       //Data from search..

@end
