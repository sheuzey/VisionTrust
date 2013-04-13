//
//  ViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/11/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>
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
    
    //Set textfields and button alpha to 0..
    self.loginButton.alpha = self.passwordField.alpha = self.usernameField.alpha = 0.0;
    
    
    self.passwordField.delegate = self;
    [self.passwordField setFrame:CGRectMake(self.passwordField.frame.origin.x,
                                            self.passwordField.frame.origin.y,
                                            self.passwordField.frame.size.width,
                                            self.passwordField.frame.size.height + 12)];
    
    self.usernameField.delegate = self;
    self.loginTable.delegate = self;
    self.loginTable.dataSource = self;
}

- (void)viewDidAppear:(BOOL)animated
{
    sleep(1);    
    [UIView animateWithDuration:0.5
                     animations:^(void) {
                         //Move logo frame up..
                         [[self.view.subviews lastObject] setCenter:CGPointMake(self.view.center.x,
                                                                               self.view.center.y - 150)];
                     }
                     completion:^(BOOL finished){
                         /*[UIView animateWithDuration:1.0
                                          animations:^(void){
                                              self.loginButton.alpha =
                                              self.passwordField.alpha =
                                              self.usernameField.alpha = 1.0;
                                          }];*/
                     }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    UITextField *inputField;
    if(cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        inputField = [[UITextField alloc] initWithFrame:CGRectMake(120, 12, 185, 30)];
        inputField.adjustsFontSizeToFitWidth = YES;
        inputField.textColor = [UIColor colorWithRed:51.0f/255.0f green:102.0f/255.0f blue:153.0f/255.0f alpha:1];
        [cell addSubview:inputField];
    }
    inputField.keyboardType = UIKeyboardTypeDefault;
    switch ([indexPath row]) {
        case 0:
            inputField.placeholder = @"username";
            break;
        case 1:
            inputField.placeholder = @"password";
            inputField.secureTextEntry = YES;
            break;
    }
    return cell;
}








- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
