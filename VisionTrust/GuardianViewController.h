//
//  GuardianViewController.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/20/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Child.h"
#import "Guardian.h"
#import "OccupationType.h"
#import "GuardianStatus.h"

@interface GuardianViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) Child *child;
@property (nonatomic, strong) Guardian *guardian;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
