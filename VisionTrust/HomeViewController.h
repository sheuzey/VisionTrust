//
//  HomeViewController.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/13/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HomeViewController;

@interface HomeViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (strong, nonatomic) IBOutlet UICollectionView *menuCollection;
@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSArray *children;

@end
