//
//  OtherChildrenViewController.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/20/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Guardian.h"
#import "Child.h"

@interface AllChildrenViewController : UITableViewController

@property (nonatomic, strong) Guardian *guardian;

@end
