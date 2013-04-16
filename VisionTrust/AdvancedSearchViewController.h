//
//  AdvancedSearchViewController.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/15/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AdvancedSearchViewController;

@protocol QuitAdvancedSearchProtocol

- (void)exitAdvancedSearch;

@end

@interface AdvancedSearchViewController : UIViewController

@property (weak, nonatomic) id<QuitAdvancedSearchProtocol>delegate;

@end
