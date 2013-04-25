//
//  ViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/11/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeViewController.h"
#import "User+SetupUser.h"

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *labelForHomePage;

@end

@implementation LoginViewController

#define LOGO_TAG 300
#define USERNAME_TAG 100
#define PASSWORD_TAG 200

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Clear the table background view and disable scrolling..
    self.loginTable.backgroundView = nil;
    self.loginTable.scrollEnabled = NO;
    //self.database = [[VisionTrustDatabase alloc] init];
    self.database = [VisionTrustDatabase vtDatabase];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //Set title of login button when selected..
    [self.loginButton setTitle:@"Log in" forState:UIControlStateNormal];
    
    //Create logo view, set its tag and add as subview..
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"VisionTrustLogo.jpg"]];
    [logoView setCenter:CGPointMake(self.view.center.x, self.view.center.y - 30)];
    [logoView setTag:LOGO_TAG];
    [self.view addSubview:logoView];
    
    //Set button and table alpha to 0..
    [self.loginTable setAlpha:0.0];
    [self.loginButton setAlpha:0.0];
    
    //Hide Navigation Bar..
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    sleep(1);    
    [UIView animateWithDuration:0.5
                     animations:^(void) {
                         //Move logo frame up..
                         [[self.view.subviews lastObject] setCenter:CGPointMake(self.view.center.x,
                                                                               self.view.center.y - 160)];
                     }
                     completion:^(BOOL finished){
                         [UIView animateWithDuration:0.3
                                          animations:^(void){
                                              UIView *logoView = [self.view.subviews lastObject];
                                              [self.loginTable setCenter:CGPointMake(self.view.center.x, logoView.center.y + 150)];
                                              [self.loginTable setAlpha:1.0];
                                              [self.loginButton setAlpha:1.0];
                                          }];
                     }];
}

- (IBAction)loginButtonWasPressed:(id)sender {
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    [spinner setFrame:CGRectMake(self.loginButton.frame.size.width - 40, 15, 10, 10)];
    [spinner setTag:50];
    [self.loginButton addSubview:spinner];
    
    [self.loginButton setTitle:@"Logging in" forState:UIControlStateNormal];
    
    //Get username..
    UITextField *usernameField = (UITextField *)[[self.loginTable cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]] viewWithTag:USERNAME_TAG];
    
    //Make user thread-safe..
    __block User *user;
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //Retrieve user from db..
        user = [self.database getUserByUsername:usernameField.text];
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        //If exists, authenticate..
        if(user) {
            UITextField *passwordField = (UITextField *)[[self.loginTable cellForRowAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]] viewWithTag:PASSWORD_TAG];
            
            //If provided password is correct, segue to home controller..
            if ([passwordField.text isEqualToString:user.password]) {
                self.labelForHomePage = [NSString stringWithFormat:@"Welcome %@", user.firstName];
                [self performSegueWithIdentifier:@"GoToMainPage" sender:self];
            } else {
                
                //Password incorrect...show error alert
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect Password" message:@"The password you entered is incorrect. Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
        } else {
            
            //Username incorrect...show error alert
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"The username you provided does not exist. Please try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:Nil, nil];
            [alert show];
        }
        //Remove spinner from button..
        for (UIView *view in self.loginButton.subviews) {
            if(view.tag == 50)
                [view removeFromSuperview];
        }
        [self.loginButton setTitle:@"Log in" forState:UIControlStateNormal];
    });
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"GoToMainPage"])
    {
        HomeViewController *hvc = (HomeViewController *)segue.destinationViewController;
        hvc.firstName = self.labelForHomePage;
    }
    [self.database saveDatabase];
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
        inputField = [[UITextField alloc] initWithFrame:CGRectMake(20,
                                                                   10,
                                                                   cell.bounds.size.width,
                                                                   cell.bounds.size.height)];
        inputField.adjustsFontSizeToFitWidth = YES;
        inputField.delegate = self;
        
        switch ([indexPath row])
        {
            case 0:
                inputField.placeholder = @"Username";
                [inputField setAutocorrectionType:UITextAutocorrectionTypeNo];
                [inputField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
                
                //Arbitrary tag value..
                inputField.tag = USERNAME_TAG;
                [cell addSubview:inputField];
                break;
            case 1:
                inputField.placeholder = @"Password";
                inputField.secureTextEntry = YES;
                
                //Arbitrary tag value..
                inputField.tag = PASSWORD_TAG;
                [cell addSubview:inputField];
                break;
        }
    }
    return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    for (UIView *view in self.view.subviews) {
        if (view.tag == LOGO_TAG) {
            [view removeFromSuperview];
            break;
        }
    }
    
    //Set button and table alpha to 0..
    [self.loginTable setAlpha:0.0];
    [self.loginButton setAlpha:0.0];
    
    //Retrieve password text field, clear text, and replace back into cell..
    NSIndexPath *passwordCellPath = [NSIndexPath indexPathForRow:1 inSection:0];
    UITextField *passwordField = (UITextField *)[[self.loginTable cellForRowAtIndexPath:passwordCellPath] viewWithTag:PASSWORD_TAG];
    passwordField.text = nil;
    for (UIView *view in [[self.loginTable cellForRowAtIndexPath:passwordCellPath] subviews]) {
        if (view.tag == PASSWORD_TAG) {
            [view removeFromSuperview];
            [[self.loginTable cellForRowAtIndexPath:passwordCellPath] addSubview:passwordField];
            break;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
