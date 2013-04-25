//
//  ViewController.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/11/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VisionTrustDatabase.h"

@interface LoginViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>

@property (nonatomic, retain) IBOutlet UITableView *loginTable;
@property (nonatomic, strong) VisionTrustDatabase *database;

@end