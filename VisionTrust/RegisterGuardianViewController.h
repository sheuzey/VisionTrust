//
//  RegisterGuardianViewController.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/20/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuardianViewController.h"

@class RegisterChildViewController;

@protocol GuardianRegistrationProtocol

- (void)guardianInfo:(NSMutableDictionary *)info;

@end


@interface RegisterGuardianViewController : UITableViewController

@property (nonatomic, strong) NSMutableDictionary *guardianData;
@property (nonatomic, weak) id<GuardianRegistrationProtocol>delegate;

@end
