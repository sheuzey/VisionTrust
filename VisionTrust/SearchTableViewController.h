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
@property BOOL goToUpdate;                                      //If user wanted to update a child..
@property BOOL goToDeparture;                                   //If user wanted to depart a child..
@property (strong, nonatomic) NSMutableArray *searchData;       //Data from search..
@property (strong, nonatomic) NSArray *children;                //Children from database..
@property (strong, nonatomic) VisionTrustDatabase *database;

@end
