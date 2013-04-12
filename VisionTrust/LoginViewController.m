//
//  LoginViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/11/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "LoginViewController.h"
#import "User+SetupUser.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Fill background color..
    [self.view setBackgroundColor:[UIColor colorWithRed:0.0
                                                  green:0.1
                                                   blue:0.2
                                                  alpha:1.0]];
}

- (void)useDocument
{
    //If database does not exist on disk, create it..
    if(![[NSFileManager defaultManager] fileExistsAtPath:[self.loginDatabase.fileURL path]]){
        [self.loginDatabase saveToURL:self.loginDatabase.fileURL
                     forSaveOperation:UIDocumentSaveForCreating
                    completionHandler:^(BOOL success){
                        [self.loginDatabase.managedObjectContext performBlock:^{
                            
                            //Add sample users to database to test authentication..
                            [User userWithUsername:@"steve" andPassword:@"heuzey" inManagedObjectContext:self.loginDatabase.managedObjectContext];
                            [User userWithUsername:@"adam" andPassword:@"oakley" inManagedObjectContext:self.loginDatabase.managedObjectContext];
                        }];
        }];
    } else if (self.loginDatabase.documentState == UIDocumentStateClosed){
        [self.loginDatabase openWithCompletionHandler:^(BOOL success){
            
        }];
    } else if (self.loginDatabase.documentState == UIDocumentStateNormal){
        
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
