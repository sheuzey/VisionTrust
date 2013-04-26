//
//  UpdateOptionsViewController.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/25/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UpdateOptionsViewController;

@protocol UpdateOptionProtocol

- (void)optionInfo:(NSMutableArray *)info;

@end

@interface UpdateOptionsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *selectedOptions;
@property (nonatomic, strong) NSString *otherActivity;
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, weak) id<UpdateOptionProtocol>delegate;

@end
