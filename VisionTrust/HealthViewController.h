//
//  HealthViewController.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/27/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Child.h"
#import "Interactions.h"
#import "ViewUpdateViewController.h"

@interface HealthViewController : UITableViewController

@property (nonatomic, strong) Interactions *interaction;
@property (nonatomic, weak) id<ExitCategory>delegate;

@end
