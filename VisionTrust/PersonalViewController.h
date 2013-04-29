//
//  PersonalViewController.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/19/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PageRootViewController.h"
#import "Child.h"
#import "Guardian.h"
#import "Project.h"

@interface PersonalViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) UIImageView *childImageView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) Child *child;
@property (nonatomic, strong) NSArray *guardians;
@property (nonatomic, assign) NSInteger selectedGuardianIndex;

- (id)initWithChild:(Child *)child;

@end
