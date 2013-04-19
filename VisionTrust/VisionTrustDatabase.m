//
//  VisionTrustDatabase.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/18/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "VisionTrustDatabase.h"

@interface VisionTrustDatabase()
@property (nonatomic, strong) UIManagedDocument *database;
@end

@implementation VisionTrustDatabase

- (void)insertSampleData
{
    [self.database.managedObjectContext performBlock:^{
        
        //Add sample users to database to test authentication..
        [User userWithUsername:@"steve" andPassword:@"pwd" andFirstName:@"Stephen" andLastName:@"Heuzey" inManagedObjectContext:self.database.managedObjectContext];
        [User userWithUsername:@"adam" andPassword:@"pwd" andFirstName:@"Adam" andLastName:@"Oakley" inManagedObjectContext:self.database.managedObjectContext];
        [Child childWithFirstName:@"Julio" LastName:@"Gonzalas" uniqueID:[NSNumber numberWithInteger:1] gender:@"Male" dob:@"4/1/2000" country:@"Mexico" address:@"1 main avenue" city:@"Mexico City" picture:@"child.jpeg" isActive:[NSNumber numberWithInteger:1] inContext:self.database.managedObjectContext];
        [Child childWithFirstName:@"Hugo" LastName:@"Chavez" uniqueID:[NSNumber numberWithInteger:2] gender:@"Male" dob:@"7/28/1954" country:@"Venezuala" address:@"5 mansion place" city:@"Major City" picture:@"child.jpeg" isActive:[NSNumber numberWithInteger:1] inContext:self.database.managedObjectContext];
        [Child childWithFirstName:@"Kim Jong" LastName:@"Un" uniqueID:[NSNumber numberWithInteger:3] gender:@"Male" dob:@"1/1/1985" country:@"North Korea" address:@"255 Charlie Place" city:@"PyongYang" picture:@"child.jpeg" isActive:[NSNumber numberWithInteger:1] inContext:self.database.managedObjectContext];
        [Child childWithFirstName:@"Katie" LastName:@"Smith" uniqueID:[NSNumber numberWithInteger:4] gender:@"Female" dob:@"9/30/2005" country:@"Germany" address:@"2 3rd street" city:@"Berlin" picture:@"child.jpeg" isActive:[NSNumber numberWithInteger:0] inContext:self.database.managedObjectContext];
        [Child childWithFirstName:@"Vladimir" LastName:@"Putin" uniqueID:[NSNumber numberWithInteger:5] gender:@"Male" dob:@"10/7/1952" country:@"Russia" address:@"33 Communal Drive" city:@"St. Petersburg" picture:@"child.jpeg" isActive:[NSNumber numberWithInteger:0] inContext:self.database.managedObjectContext];
        [Child childWithFirstName:@"William" LastName:@"Brown" uniqueID:[NSNumber numberWithInteger:6] gender:@"Male" dob:@"2/1/1965" country:@"US" address:@"10 cedar road" city:@"Orlando, Florida" picture:@"child.jpeg" isActive:[NSNumber numberWithInteger:1] inContext:self.database.managedObjectContext];
        [Child childWithFirstName:@"Stefani" LastName:@"Germanotta" uniqueID:[NSNumber numberWithInteger:7] gender:@"Female" dob:@"3/28/1986" country:@"US" address:@"50 Crazy blvd." city:@"New York City" picture:@"child.jpeg" isActive:[NSNumber numberWithInteger:1] inContext:self.database.managedObjectContext];
        NSLog(@"ADDED DATA TO DATABASE");
    }];
}

- (void)useDocument
{
    //If database does not exist on disk, create it..
    if(![[NSFileManager defaultManager] fileExistsAtPath:[self.database.fileURL path]]){
        [self.database saveToURL:self.database.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success){
            [self insertSampleData];
        }];
    } else if (self.database.documentState == UIDocumentStateClosed){
        [self.database openWithCompletionHandler:^(BOOL success){
            //Test to see if database is null. If so, insert sample data..
            NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Child"];
            //request.predicate = [NSPredicate predicateWithFormat:@"username = %@", @"steve"];
            NSError *error = nil;
            NSArray *userArray = [self.database.managedObjectContext executeFetchRequest:request error:&error];
            if(!userArray){
                [self insertSampleData];
            }
            Child *temp = [[self.database.managedObjectContext executeFetchRequest:request error:&error] lastObject];
            NSLog(@"Last child in database: %@ %@", temp.firstName, temp.lastName);
        }];
    }
}

- (void)setDatabase:(UIManagedDocument *)database
{
    if (_database != database) {
        _database = database;
        [self useDocument];
    }
}

- (id)init
{
    self = [super init];
    
    //Create database..
    
    //Get documents directory for database file..
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
        
    //Append the name of the database to use..
    url = [url URLByAppendingPathComponent:@"Default Login Database"];
    self.database = [[UIManagedDocument alloc] initWithFileURL:url];
    
    return self;
}

- (User *)getUserByUsername:(NSString *)username
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    request.predicate = [NSPredicate predicateWithFormat:@"username = %@", [username stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    
    NSError *error = nil;
    NSArray *userArray = [self.database.managedObjectContext executeFetchRequest:request error:&error];
    
    return [userArray lastObject];
}

- (NSArray *)getAllChildren
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Child"];
    NSError *error = nil;
    return [self.database.managedObjectContext executeFetchRequest:request error:&error];
}

- (void)saveDatabase
{
    [self.database saveToURL:self.database.fileURL forSaveOperation:UIDocumentSaveForOverwriting completionHandler:^(BOOL success) {
        if (success) {
            NSLog(@"DATABASE SAVED!");
        }
        else {
            NSLog(@"Database didn't save..");
        }
    }];
}

@end
