//
//  FavoriteSubjectsViewController.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/21/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FavoriteSubjectsViewController;

@protocol FavoriteSubjectsProtocol

- (void)favoriteSubjects:(NSMutableArray *)subjects;

@end

@interface FavoriteSubjectsViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *favoriteSubjects;
@property (nonatomic, weak) id<FavoriteSubjectsProtocol>delegate;

@end
