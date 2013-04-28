//
//  ViewUpdateViewController.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/28/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Child.h"
#import "Guardian.h"
#import "Project.h"
#import "Interactions.h"
#import "PersonalViewController.h"

@protocol ExitViewUpateProtocol

- (void)exitViewUpdate;

@end

@protocol ExitCategory

- (void)exitCategory;

@end

@interface ViewUpdateViewController : PersonalViewController

@property (strong, nonatomic) IBOutlet UIImageView *childImageView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIToolbar *navBar;
@property (strong, nonatomic) NSDate *date;                         //To get interaction at specified date..
@property (weak, nonatomic) id<ExitViewUpateProtocol>delegate;
@end
