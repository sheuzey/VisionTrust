//
//  AdvancedSearchViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/15/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "AdvancedSearchViewController.h"

@interface AdvancedSearchViewController ()

@end

@implementation AdvancedSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (IBAction)searchButtonPressed:(id)sender {
    [self.delegate exitAdvancedSearch];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
