//
//  AcademicViewController.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/26/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Child.h"
#import "Interactions.h"
#import "Update.h"
#import "UpdateOptions.h"
#import "OptionCategories.h"
#import "ViewUpdateViewController.h"

@interface AcademicViewController : UITableViewController

@property (nonatomic, strong) Interactions *interaction;
@property (nonatomic, weak) id<ExitCategory>delegate;

@end
