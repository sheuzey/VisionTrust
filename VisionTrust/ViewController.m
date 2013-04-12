//
//  ViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/11/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    //Fill background color..
    [self.view setBackgroundColor:[UIColor colorWithRed:0.0
                                                  green:0.1
                                                   blue:0.2
                                                  alpha:1.0]];
}

- (void)viewDidAppear:(BOOL)animated
{
    sleep(3);
    [self performSegueWithIdentifier:@"GoToLogin" sender:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
