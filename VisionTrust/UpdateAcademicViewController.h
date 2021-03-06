//
//  RegisterAcademicViewController.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/21/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UpdateAcademicViewController;

@protocol UpdateAcademicProtocol

- (void)academicInfo:(NSMutableDictionary *)info;

@end

@interface UpdateAcademicViewController : UITableViewController <UIActionSheetDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) NSMutableDictionary *academicData;
@property (nonatomic, strong) NSMutableArray *favoriteSubjects;
@property (nonatomic, weak) id<UpdateAcademicProtocol>delegate;

@end
