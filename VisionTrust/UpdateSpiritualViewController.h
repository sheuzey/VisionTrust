//
//  UpdateSpiritualViewController.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/25/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UpdateSpiritualViewController;

@protocol UpdateSpiritualProtocol

- (void)spiritualInfo:(NSMutableDictionary *)info;

@end

@interface UpdateSpiritualViewController : UITableViewController <UIPickerViewDataSource, UIPickerViewDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) NSMutableDictionary *spiritualData;
@property (strong, nonatomic) NSMutableArray *spiritualActivities;
@property (nonatomic, weak) id<UpdateSpiritualProtocol>delegate;

@end
