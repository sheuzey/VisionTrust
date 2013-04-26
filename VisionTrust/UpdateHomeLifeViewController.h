//
//  UpdateHomeLifeViewController.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/25/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UpdateHomeLifeViewController;

@protocol UpdateHomeProtocol

- (void)homeInfo:(NSMutableDictionary *)info;

@end

@interface UpdateHomeLifeViewController : UITableViewController

@property (nonatomic, strong) NSMutableDictionary *homeData;
@property (nonatomic, weak) id<UpdateHomeProtocol>delegate;

@end
