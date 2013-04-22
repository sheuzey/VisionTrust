//
//  RegisterViewController.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/19/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "PersonalViewController.h"
#import "VisionTrustDatabase.h"

@interface RegisterChildViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIActionSheetDelegate, UIPickerViewDataSource, UIPickerViewDelegate>

@property (strong, nonatomic) IBOutlet UIImageView *childImageView;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) VisionTrustDatabase *database;

@end
