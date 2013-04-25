//
//  UpdateViewController.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/25/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalViewController.h"
#import "Child.h"
#import "Guardian.h"
#import "Project.h"

@interface UpdateViewController : PersonalViewController
@property (strong, nonatomic) IBOutlet UIImageView *childImageView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) Child *child;
@property (nonatomic, strong) NSArray *guardians;

@end
