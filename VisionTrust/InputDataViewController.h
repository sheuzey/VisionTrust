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

- (void)giveBackData:(id)data;

@end

@interface InputDataViewController : UITableViewController <UITextFieldDelegate>
@property (nonatomic, strong) NSString *titleString;
@property (nonatomic, strong) NSString *dataString;
@property (nonatomic, weak) id<GetData>delegate;
@end
