//
//  HomeViewController.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/13/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VisionTrustDatabase.h"

@interface HomeViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *welcomeLabel;
@property (strong, nonatomic) IBOutlet UICollectionView *menuCollection;
@property (strong, nonatomic) NSString *firstName;
@property (nonatomic, strong) VisionTrustDatabase *database;

@end
