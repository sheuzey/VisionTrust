//
//  InputDataViewController.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/20/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class InputDataViewController;

@protocol GetData

//Used to give data back to calling view controller
- (void)giveBackData:(NSString *)data;

@end

@interface InputDataViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) NSString *dataString;
@property (nonatomic, weak) id<GetData>delegate;

@end
