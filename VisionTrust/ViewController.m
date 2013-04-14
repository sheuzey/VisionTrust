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

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (strong, nonatomic) NSString *username;
@property (strong, nonatomic) NSString *password;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //Hide Navigation Bar..
    self.navigationController.navigationBarHidden = YES;
    
    //Add logo to view..
    UIImageView *logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"VisionTrustLogo.jpg"]];
    [logoView setCenter:CGPointMake(self.view.center.x, self.view.center.y - 30)];
    [self.view addSubview:logoView];
    
    //Set button and table alpha to 0..
    [self.loginTable setAlpha:0.0];
    [self.loginButton setAlpha:0.0];
    [self.loginButton setTitle:@"Logging In" forState:UIControlStateSelected];
    
    //Set table background color and disable scrolling..
    self.loginTable.backgroundView = nil;
    self.loginTable.scrollEnabled = NO;
    self.loginTable.backgroundColor = self.view.backgroundColor;
}

- (void)insertSampleData
{
    [self.loginDatabase.managedObjectContext performBlock:^{
        
        //Add sample users to database to test authentication..
        [User userWithUsername:@"steve" andPassword:@"heuzey" inManagedObjectContext:self.loginDatabase.managedObjectContext];
        [User userWithUsername:@"adam" andPassword:@"oakley" inManagedObjectContext:self.loginDatabase.managedObjectContext];
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
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //If database is nil, create it..
    if(!self.loginDatabase){
        
        //Get documents directory for database file..
        NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
        //Append the name of the database to use..
        url = [url URLByAppendingPathComponent:@"Default Login Database"];
        self.loginDatabase = [[UIManagedDocument alloc] initWithFileURL:url];
    }
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
                         [UIView animateWithDuration:0.3
                                          animations:^(void){
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
    UITextField *usernameField = (UITextField *)[[self.loginTable cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]] viewWithTag:100];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    request.predicate = [NSPredicate predicateWithFormat:@"username = %@", usernameField.text];
    
    NSError *error = nil;
    NSArray *userArray = [self.loginDatabase.managedObjectContext executeFetchRequest:request error:&error];

    User *user = [userArray lastObject];
    
    //If exists, authenticate..
    if(user) {
        UITextField *passwordField = (UITextField *)[[self.loginTable cellForRowAtIndexPath:[NSIndexPath indexPathForItem:1 inSection:0]] viewWithTag:200];
        
        //If provided password is correct, segue to home controller..
        if (passwordField.text == user.password) {
            [self.loginDatabase saveToURL:self.loginDatabase.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:^(BOOL success){
                if(success)
                    NSLog(@"IT SAVED!");
            }];
            [self performSegueWithIdentifier:@"GoToMainPage" sender:self];
        } else {
            
            //Password incorrect...show error alert
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect Password" message:@"The password you entered is incorrect. Please try again." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    } else {
        
        //Username incorrect...show error alert
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"The username you provided was not does not exist. Please try again." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:Nil, nil];
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
                
                //Arbitrary tag value..
                inputField.tag = 100;
                [cell addSubview:inputField];
                break;
            case 1:
                inputField.placeholder = @"Password";
                inputField.secureTextEntry = YES;
                
                //Arbitrary tag value..
                inputField.tag = 200;
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
