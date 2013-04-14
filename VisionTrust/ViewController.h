//
//  ViewController.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/11/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>

@property (nonatomic, retain) IBOutlet UITableView *loginTable;
@property (nonatomic, strong) UIManagedDocument *loginDatabase;

@end