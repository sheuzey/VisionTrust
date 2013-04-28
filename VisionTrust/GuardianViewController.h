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
#import "ViewUpdateViewController.h"

@interface GuardianViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) Guardian *guardian;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, weak) id<ExitCategory>delegate;
@property (strong, nonatomic) IBOutlet UIToolbar *navBar;

@end
