//
//  RegisterGuardianViewController.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/20/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GuardianViewController.h"
#import "VisionTrustDatabase.h"

@protocol GuardianRegistrationProtocol

- (void)guardianInfo:(NSMutableDictionary *)info;

@end


@interface RegisterGuardianViewController : UITableViewController

@property (nonatomic, strong) NSMutableDictionary *guardianData;
@property BOOL giveBackGuardianFromData;
@property (nonatomic, weak) id<GuardianRegistrationProtocol>delegate;

@end
