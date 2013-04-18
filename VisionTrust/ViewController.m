//
//  ViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/11/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "ViewController.h"
#import "HomeViewController.h"
#import "User+SetupUser.h"
#import "Child+SetupChild.h"
#import "SearchTableViewController.h"
#import "VisionTrustDatabase.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;
@property (strong, nonatomic) NSString *labelForHomePage;

@end

@implementation ViewController

#define LOGO_TAG 100
#define USERNAME_TAG 100
#define PASSWORD_TAG 200


/*- (void)insertSampleData
{
    [self.loginDatabase.managedObjectContext performBlock:^{
        
        //Add sample users to database to test authentication..
        [User userWithUsername:@"steve" andPassword:@"pwd" andFirstName:@"Stephen" andLastName:@"Heuzey" inManagedObjectContext:self.loginDatabase.managedObjectContext];
        [User userWithUsername:@"adam" andPassword:@"pwd" andFirstName:@"Adam" andLastName:@"Oakley" inManagedObjectContext:self.loginDatabase.managedObjectContext];
        [Child childWithFirstName:@"Julio" LastName:@"Gonzalas" uniqueID:[NSNumber numberWithInteger:1] gender:@"Male" dob:@"4/1/2000" country:@"Mexico" address:@"1 main avenue" city:@"Mexico City" picture:@"child.jpeg" isActive:[NSNumber numberWithInteger:1] inContext:self.loginDatabase.managedObjectContext];
        [Child childWithFirstName:@"Hugo" LastName:@"Chavez" uniqueID:[NSNumber numberWithInteger:2] gender:@"Male" dob:@"7/28/1954" country:@"Venezuala" address:@"5 mansion place" city:@"Major City" picture:@"child.jpeg" isActive:[NSNumber numberWithInteger:1] inContext:self.loginDatabase.managedObjectContext];
        [Child childWithFirstName:@"Kim Jong" LastName:@"Un" uniqueID:[NSNumber numberWithInteger:3] gender:@"Male" dob:@"1/1/1985" country:@"North Korea" address:@"255 Charlie Place" city:@"PyongYang" picture:@"child.jpeg" isActive:[NSNumber numberWithInteger:1] inContext:self.loginDatabase.managedObjectContext];
        [Child childWithFirstName:@"Katie" LastName:@"Smith" uniqueID:[NSNumber numberWithInteger:4] gender:@"Female" dob:@"9/30/2005" country:@"Germany" address:@"2 3rd street" city:@"Berlin" picture:@"child.jpeg" isActive:[NSNumber numberWithInteger:0] inContext:self.loginDatabase.managedObjectContext];
        [Child childWithFirstName:@"Vladimir" LastName:@"Putin" uniqueID:[NSNumber numberWithInteger:5] gender:@"Male" dob:@"10/7/1952" country:@"Russia" address:@"33 Communal Drive" city:@"St. Petersburg" picture:@"child.jpeg" isActive:[NSNumber numberWithInteger:0] inContext:self.loginDatabase.managedObjectContext];
        [Child childWithFirstName:@"William" LastName:@"Brown" uniqueID:[NSNumber numberWithInteger:6] gender:@"Male" dob:@"2/1/1965" country:@"US" address:@"10 cedar road" city:@"Orlando, Florida" picture:@"child.jpeg" isActive:[NSNumber numberWithInteger:1] inContext:self.loginDatabase.managedObjectContext];
        [Child childWithFirstName:@"Stefani" LastName:@"Germanotta" uniqueID:[NSNumber numberWithInteger:7] gender:@"Female" dob:@"3/28/1986" country:@"US" address:@"50 Crazy blvd." city:@"New York City" picture:@"child.jpeg" isActive:[NSNumber numberWithInteger:1] inContext:self.loginDatabase.managedObjectContext];
    }];
}

- (void)useDocument
{
    //If database does not exist on disk, create it..
    if(![[NSFileManager defaultManager] fileExistsAtPath:[self.loginDatabase.fileURL path]]){
        [self.loginDatabase saveToURL:self.loginDatabase.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success){
            [self insertSampleData];
            }];
    } else if (self.loginDatabase.documentState == UIDocumentStateClosed){
        [self.loginDatabase openWithCompletionHandler:^(BOOL success){
            //Test to see if database is null. If so, insert sample data..
            NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
            request.predicate = [NSPredicate predicateWithFormat:@"username = %@", @"steve"];
            NSError *error = nil;
            NSArray *userArray = [self.loginDatabase.managedObjectContext executeFetchRequest:request error:&error];
            if(!userArray){
                [self insertSampleData];
            }
            User *temp = [[self.loginDatabase.managedObjectContext executeFetchRequest:request error:&error] lastObject];
            NSLog(@"Last user in database: %@ %@", temp.username, temp.password);
        }];
    }
}

- (void)setLoginDatabase:(UIManagedDocument *)loginDatabase
{
    if(_loginDatabase != loginDatabase){
        _loginDatabase = loginDatabase;
        [self useDocument];
    }
}*/

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Set title of login button when selected..
    [self.loginButton setTitle:@"Logging In" forState:UIControlStateSelected];
    
    //Clear the table background view and disable scrolling..
    self.loginTable.backgroundView = nil;
    self.loginTable.scrollEnabled = NO;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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
    
    /*//If database is nil, create it..
    if(!self.loginDatabase){
        
        //Get documents directory for database file..
        NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
        //Append the name of the database to use..
        url = [url URLByAppendingPathComponent:@"Default Login Database"];
        self.loginDatabase = [[UIManagedDocument alloc] initWithFileURL:url];
    }*/
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
    [spinner setTag:100];
    [self.loginButton addSubview:spinner];
    
    self.loginButton.titleLabel.text = @"Logging in";
    
    //Retrieve user from db..
    UITextField *usernameField = (UITextField *)[[self.loginTable cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]] viewWithTag:USERNAME_TAG];
    
    /*NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    request.predicate = [NSPredicate predicateWithFormat:@"username = %@", [usernameField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    
    NSError *error = nil;
    NSArray *userArray = [self.loginDatabase.managedObjectContext executeFetchRequest:request error:&error];

    User *user = [userArray lastObject];*/

    User *user = [VisionTrustDatabase getUserByUsername:usernameField.text];
    
    //If exists, authenticate..
    if(user) {
        UITextField *passwordField = (UITextField *)[[self.loginTable cellForRowAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]] viewWithTag:PASSWORD_TAG];
        
        //If provided password is correct, segue to home controller..
        if ([passwordField.text isEqualToString:user.password]) {
            /*[self.loginDatabase saveToURL:self.loginDatabase.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:^(BOOL success){
                if(success)
                    NSLog(@"IT SAVED!");
            }];*/
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
        if(view.tag == 100)
            [view removeFromSuperview];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"GoToMainPage"])
    {
        HomeViewController *hvc = (HomeViewController *)segue.destinationViewController;
        hvc.firstName = self.labelForHomePage;
        hvc.children = [VisionTrustDatabase getAllChildren];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier]; //forIndexPath:indexPath];
    
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

/*- (NSArray *)getArrayOfChildren
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Child"];
    NSError *error = nil;
    return [self.loginDatabase.managedObjectContext executeFetchRequest:request error:&error];
}*/

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
