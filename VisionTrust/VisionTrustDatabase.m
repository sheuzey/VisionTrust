//
//  VisionTrustDatabase.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/18/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "VisionTrustDatabase.h"

@interface VisionTrustDatabase()

@end

@implementation VisionTrustDatabase

+ (void)insertSampleData:(UIManagedDocument *)document
{
    [document.managedObjectContext performBlock:^{
        
        //Add sample users to database to test authentication..
        [User userWithUsername:@"steve" andPassword:@"pwd" andFirstName:@"Stephen" andLastName:@"Heuzey" inManagedObjectContext:document.managedObjectContext];
        [User userWithUsername:@"adam" andPassword:@"pwd" andFirstName:@"Adam" andLastName:@"Oakley" inManagedObjectContext:document.managedObjectContext];
        [Child childWithFirstName:@"Julio" LastName:@"Gonzalas" uniqueID:[NSNumber numberWithInteger:1] gender:@"Male" dob:@"4/1/2000" country:@"Mexico" address:@"1 main avenue" city:@"Mexico City" picture:@"child.jpeg" isActive:[NSNumber numberWithInteger:1] inContext:document.managedObjectContext];
        [Child childWithFirstName:@"Hugo" LastName:@"Chavez" uniqueID:[NSNumber numberWithInteger:2] gender:@"Male" dob:@"7/28/1954" country:@"Venezuala" address:@"5 mansion place" city:@"Major City" picture:@"child.jpeg" isActive:[NSNumber numberWithInteger:1] inContext:document.managedObjectContext];
        [Child childWithFirstName:@"Kim Jong" LastName:@"Un" uniqueID:[NSNumber numberWithInteger:3] gender:@"Male" dob:@"1/1/1985" country:@"North Korea" address:@"255 Charlie Place" city:@"PyongYang" picture:@"child.jpeg" isActive:[NSNumber numberWithInteger:1] inContext:document.managedObjectContext];
        [Child childWithFirstName:@"Katie" LastName:@"Smith" uniqueID:[NSNumber numberWithInteger:4] gender:@"Female" dob:@"9/30/2005" country:@"Germany" address:@"2 3rd street" city:@"Berlin" picture:@"child.jpeg" isActive:[NSNumber numberWithInteger:0] inContext:document.managedObjectContext];
        [Child childWithFirstName:@"Vladimir" LastName:@"Putin" uniqueID:[NSNumber numberWithInteger:5] gender:@"Male" dob:@"10/7/1952" country:@"Russia" address:@"33 Communal Drive" city:@"St. Petersburg" picture:@"child.jpeg" isActive:[NSNumber numberWithInteger:0] inContext:document.managedObjectContext];
        [Child childWithFirstName:@"William" LastName:@"Brown" uniqueID:[NSNumber numberWithInteger:6] gender:@"Male" dob:@"2/1/1965" country:@"US" address:@"10 cedar road" city:@"Orlando, Florida" picture:@"child.jpeg" isActive:[NSNumber numberWithInteger:1] inContext:document.managedObjectContext];
        [Child childWithFirstName:@"Stefani" LastName:@"Germanotta" uniqueID:[NSNumber numberWithInteger:7] gender:@"Female" dob:@"3/28/1986" country:@"US" address:@"50 Crazy blvd." city:@"New York City" picture:@"child.jpeg" isActive:[NSNumber numberWithInteger:1] inContext:document.managedObjectContext];
        NSLog(@"ADDED DATA TO DATABASE");
    }];
}

+ (void)useDocument:(UIManagedDocument *)document
{
    //If database does not exist on disk, create it..
    if(![[NSFileManager defaultManager] fileExistsAtPath:[document.fileURL path]]){
        [document saveToURL:document.fileURL forSaveOperation:UIDocumentSaveForCreating completionHandler:^(BOOL success){
            [self insertSampleData:document];
        }];
    } else if (document.documentState == UIDocumentStateClosed){
        [document openWithCompletionHandler:^(BOOL success){
            //Test to see if database is null. If so, insert sample data..
            NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
            request.predicate = [NSPredicate predicateWithFormat:@"username = %@", @"steve"];
            NSError *error = nil;
            NSArray *userArray = [document.managedObjectContext executeFetchRequest:request error:&error];
            if(!userArray){
                [self insertSampleData:document];
            }
            User *temp = [[document.managedObjectContext executeFetchRequest:request error:&error] lastObject];
            NSLog(@"Last user in database: %@ %@", temp.username, temp.password);
        }];
    }
}

+ (UIManagedDocument *)database
{
    UIManagedDocument *document;
    
    //Get documents directory for database file..
    NSURL *url = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
    //Append the name of the database to use..
    url = [url URLByAppendingPathComponent:@"Default Login Database"];
    document = [[UIManagedDocument alloc] initWithFileURL:url];
    
    [self useDocument:document];
    
    return document;
}

+ (User *)getUserByUsername:(NSString *)username
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    request.predicate = [NSPredicate predicateWithFormat:@"username = %@", [username stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]];
    
    NSError *error = nil;
    NSArray *userArray = [self.database.managedObjectContext executeFetchRequest:request error:&error];
    if ([userArray count] == 0) {
        NSLog(@"no user was queried!");
    } else{
        NSLog(@"there is a user!");
    }
    
    return [userArray lastObject];
}

+ (NSArray *)getAllChildren
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Child"];
    NSError *error = nil;
    return [self.database.managedObjectContext executeFetchRequest:request error:&error];
}



@end
