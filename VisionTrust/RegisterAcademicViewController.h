//
//  RegisterAcademicViewController.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/21/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RegisterAcademicViewController;

@protocol AcademicRegistrationProtocol

- (void)academicInfo:(NSMutableDictionary *)info;

@end

@interface RegisterAcademicViewController : UITableViewController <UIActionSheetDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) NSMutableDictionary *academicData;
@property (nonatomic, weak) id<AcademicRegistrationProtocol>delegate;

@end
