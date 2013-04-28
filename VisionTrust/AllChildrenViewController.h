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

@protocol ExitAllChildrenProtocol

- (void)exitAllChildren;

@end

@interface AllChildrenViewController : UITableViewController

@property (nonatomic, strong) Guardian *guardian;
@property (nonatomic, weak) id<ExitAllChildrenProtocol>delegate;
@property (strong, nonatomic) IBOutlet UIToolbar *navBar;

@end
