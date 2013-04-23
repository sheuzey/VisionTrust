//
//  SearchTableViewController.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/14/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Child.h"
#import "VisionTrustDatabase.h"

@interface SearchTableViewController : UITableViewController <UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong, nonatomic) NSMutableArray *searchData;       //Data from search..
@property (strong, nonatomic) NSArray *children;                //Children from database..
@property (nonatomic, strong) VisionTrustDatabase *database;

@end
