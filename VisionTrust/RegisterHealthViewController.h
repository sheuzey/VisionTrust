//
//  RegisterHealthViewController.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/22/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RegisterHealthViewController;

@protocol HealthRegistrationProtocol

- (void)healthInfo:(NSMutableDictionary *)info;

@end

@interface RegisterHealthViewController : UITableViewController <UIActionSheetDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) NSMutableDictionary *healthData;
@property (nonatomic, weak) id<HealthRegistrationProtocol>delegate;

@end
