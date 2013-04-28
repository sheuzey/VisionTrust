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
#import "Interactions.h"
#import "VisionTrustDatabase.h"

@class UpdateViewController;

@protocol ExitUpdateProtocol

- (void)exitUpdate;

@end

@interface UpdateViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *childImageView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) VisionTrustDatabase *database;
@property (strong, nonatomic) Child *child;
@property (nonatomic, strong) NSMutableArray *guardians;
@property (nonatomic, weak) id<ExitUpdateProtocol>delegate;

@end
