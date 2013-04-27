//
//  UpdateListViewController.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/25/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Child.h"
#import "Interactions.h"
#import "Update.h"

@class UpdateListViewController;

@protocol ExitListProtocol

- (void)exitUpdateList;

@end

@interface UpdateListViewController : UITableViewController
@property (nonatomic, strong) Child *child;
@property (nonatomic, weak) id<ExitListProtocol>delegate;

@end
