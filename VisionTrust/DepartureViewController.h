//
//  DepartureViewController.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/29/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VisionTrustDatabase.h"
#import "Child.h"
#import "Interactions.h"

@protocol ExitDepartureProtocol

- (void)exitDeparture;

@end

@interface DepartureViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *childImageView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UINavigationItem *navBar;
@property (strong, nonatomic) Child *child;
@property (weak, nonatomic) id<ExitDepartureProtocol>delegate;


@end
