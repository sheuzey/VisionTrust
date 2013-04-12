//
//  ViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/11/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationController.navigationBarHidden = YES;
    
    //Add logo to view..
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"VisionTrustLogo.jpg"]];
    [logoView setCenter:CGPointMake(self.view.center.x, self.view.center.y - 30)];
    [self.view addSubview:logoView];
    self.loginButton.alpha = self.passwordField.alpha = self.usernameField.alpha = 0.0;
}

- (void)viewDidAppear:(BOOL)animated
{
    sleep(1);    
    [UIView animateWithDuration:0.75
                     animations:^(void) {
                         //Move logo frame up..
                         [[self.view.subviews lastObject] setCenter:CGPointMake(self.view.center.x,
                                                                               self.view.center.y - 150)];
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:1.0
                                          animations:^(void){
                                              self.loginButton.alpha =
                                              self.passwordField.alpha =
                                              self.usernameField.alpha = 1.0;
                                          }];
                     }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
