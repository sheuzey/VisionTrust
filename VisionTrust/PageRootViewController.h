//
//  PageRootViewController.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/29/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonalViewController.h"
#import "Child.h"
#import "Guardian.h"
#import "Project.h"

@interface PageRootViewController : UIViewController <UIScrollViewDelegate>

@property (nonatomic, strong) NSArray *childList;
@property NSUInteger currentController;

@end
