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

@interface UpdateViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *childImageView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) VisionTrustDatabase *database;
@property (nonatomic, strong) Interactions *interaction;
@property (nonatomic, strong) Child *child;
@property (nonatomic, strong) NSArray *guardians;
@property (nonatomic, strong) NSMutableDictionary *academicData;

@end
