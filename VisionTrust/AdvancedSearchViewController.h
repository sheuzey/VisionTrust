//
//  AdvancedSearchViewController.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/15/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VisionTrustDatabase.h"

@class AdvancedSearchViewController;

@protocol QuitAdvancedSearchProtocol

- (void)exitAdvancedSearchWithChildren:(NSMutableArray *)children;

@end

@interface AdvancedSearchViewController : UIViewController <UIPickerViewDataSource, UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIActionSheetDelegate>

@property (weak, nonatomic) id<QuitAdvancedSearchProtocol>delegate;
@property (strong, nonatomic) VisionTrustDatabase *database;
@property (strong, nonatomic) UIActionSheet *actionSheet;
@property (strong, nonatomic) UIPickerView *pickerView;
@property (strong, nonatomic) UIToolbar *pickerToolBar;
@property (strong, nonatomic) IBOutlet UITableView *searchTable;

@end
