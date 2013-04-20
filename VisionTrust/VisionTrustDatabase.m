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
        [User userWithUsername:@"steve"
                   andPassword:@"pwd"
                  andFirstName:@"Stephen"
                   andLastName:@"Heuzey"
        inManagedObjectContext:self.database.managedObjectContext];
        [User userWithUsername:@"adam"
                   andPassword:@"pwd"
                  andFirstName:@"Adam"
                   andLastName:@"Oakley"
        inManagedObjectContext:self.database.managedObjectContext];
        [User userWithUsername:@"john"
                   andPassword:@"pwd"
                  andFirstName:@"John"
                   andLastName:@"Delano"
        inManagedObjectContext:self.database.managedObjectContext];
        
        //Create occupation types..
        OccupationType *t1 = [OccupationType typeWithDescription:@"Doctor" inContext:self.database.managedObjectContext];
        OccupationType *t2 = [OccupationType typeWithDescription:@"Engineer" inContext:self.database.managedObjectContext];
        OccupationType *t3 = [OccupationType typeWithDescription:@"Unemployed" inContext:self.database.managedObjectContext];
        OccupationType *t4 = [OccupationType typeWithDescription:@"Singer" inContext:self.database.managedObjectContext];
        OccupationType *t5 = [OccupationType typeWithDescription:@"Social Activist" inContext:self.database.managedObjectContext];
        
        //Create guardian status'..
        GuardianStatus *s1 = [GuardianStatus statusWithDescription:@"Full-Time" inContext:self.database.managedObjectContext];
        GuardianStatus *s2 = [GuardianStatus statusWithDescription:@"Part-Time" inContext:self.database.managedObjectContext];
        GuardianStatus *s3 = [GuardianStatus statusWithDescription:@"Contractor" inContext:self.database.managedObjectContext];
        GuardianStatus *s4 = [GuardianStatus statusWithDescription:@"Seasonal" inContext:self.database.managedObjectContext];
        
        //Create guardians..
        Guardian *g1 = [Guardian guardianWithFirstName:@"Pedro"
                                              lastName:@"Gonzalas"
                                                unique:[NSNumber numberWithInt:1]
                                        occupationType:t1
                                        guardianStatus:s2
                                             inContext:self.database.managedObjectContext];
        Guardian *g2 = [Guardian guardianWithFirstName:@"Lisa"
                                              lastName:@"Chavez"
                                                unique:[NSNumber numberWithInt:2]
                                        occupationType:t5
                                        guardianStatus:s1
                                             inContext:self.database.managedObjectContext];
        Guardian *g3 = [Guardian guardianWithFirstName:@"Stuart"
                                              lastName:@"Un"
                                                unique:[NSNumber numberWithInt:3]
                                        occupationType:t4
                                        guardianStatus:s4
                                             inContext:self.database.managedObjectContext];
        Guardian *g4 = [Guardian guardianWithFirstName:@"Dmitri"
                                              lastName:@"Putin"
                                                unique:[NSNumber numberWithInt:4]
                                        occupationType:t2
                                        guardianStatus:s3
                                             inContext:self.database.managedObjectContext];
        Guardian *g5 = [Guardian guardianWithFirstName:@"Caroline"
                                              lastName:@"Smith"
                                                unique:[NSNumber numberWithInt:5]
                                        occupationType:t3
                                        guardianStatus:s1
                                             inContext:self.database.managedObjectContext];
        
        //Add children with projects..
        [Child childWithFirstName:@"Julio"
                         LastName:@"Gonzalas"
                         uniqueID:[NSNumber numberWithInteger:1]
                           gender:@"Male"
                              dob:@"4/1/2000"
                          country:@"Mexico"
                          address:@"1 main avenue"
                             city:@"Mexico City"
                          picture:@"child.jpeg"
                           status:@"Active"
                         guardian:g1
             guardianRelationship:@"Father"
                          project:[Project projectWithAddress:@"50 project place"
                                                         name:@"DR-3320"
                                                           ID:[NSNumber numberWithInt:1]
                                                    inContext:self.database.managedObjectContext]
                        inContext:self.database.managedObjectContext];
        [Child childWithFirstName:@"Hugo"
                         LastName:@"Chavez"
                         uniqueID:[NSNumber numberWithInteger:2]
                           gender:@"Male"
                              dob:@"7/28/1954"
                          country:@"Venezuala"
                          address:@"5 mansion place"
                             city:@"Major City"
                          picture:@"child.jpeg"
                           status:@"Active"
                         guardian:g2
             guardianRelationship:@"Mother"
                          project:[Project projectWithAddress:@"1 vision avenue"
                                                         name:@"VEN-1099"
                                                           ID:[NSNumber numberWithInt:2]
                                                    inContext:self.database.managedObjectContext]
                        inContext:self.database.managedObjectContext];
        [Child childWithFirstName:@"Kim Jong"
                         LastName:@"Un"
                         uniqueID:[NSNumber numberWithInteger:3]
                           gender:@"Male"
                              dob:@"1/1/1985"
                          country:@"North Korea"
                          address:@"255 Charlie Place"
                             city:@"PyongYang"
                          picture:@"child.jpeg"
                           status:@"Active"
                         guardian:g3
             guardianRelationship:@"Uncle"
                          project:[Project projectWithAddress:@"23 trust blvd"
                                                         name:@"MX-454"
                                                           ID:[NSNumber numberWithInt:3]
                                                    inContext:self.database.managedObjectContext]
                        inContext:self.database.managedObjectContext];
        [Child childWithFirstName:@"Katie"
                         LastName:@"Smith"
                         uniqueID:[NSNumber numberWithInteger:4]
                           gender:@"Female"
                              dob:@"9/30/2005"
                          country:@"Germany"
                          address:@"2 3rd street"
                             city:@"Berlin"
                          picture:@"child.jpeg"
                           status:@"Inactive"
                         guardian:g5
             guardianRelationship:@"Aunt"
                          project:[Project projectWithAddress:@"50 project place"
                                                         name:@"DR-3320"
                                                           ID:[NSNumber numberWithInt:1]
                                                    inContext:self.database.managedObjectContext]
                        inContext:self.database.managedObjectContext];
        [Child childWithFirstName:@"Vladimir"
                         LastName:@"Putin"
                         uniqueID:[NSNumber numberWithInteger:5]
                           gender:@"Male"
                              dob:@"10/7/1952"
                          country:@"Russia"
                          address:@"33 Communal Drive"
                             city:@"St. Petersburg"
                          picture:@"child.jpeg"
                           status:@"Inactive"
                         guardian:g4
             guardianRelationship:@"Father"
                          project:[Project projectWithAddress:@"1 vision avenue"
                                                         name:@"VEN-1099"
                                                           ID:[NSNumber numberWithInt:2]
                                                    inContext:self.database.managedObjectContext]
                        inContext:self.database.managedObjectContext];
        [Child childWithFirstName:@"William"
                         LastName:@"Brown"
                         uniqueID:[NSNumber numberWithInteger:6]
                           gender:@"Male"
                              dob:@"2/1/1965"
                          country:@"US"
                          address:@"10 cedar road"
                             city:@"Orlando, Florida"
                          picture:@"child.jpeg"
                           status:@"Active"
                         guardian:g5
             guardianRelationship:@"Step Aunt"
                          project:[Project projectWithAddress:@"23 trust blvd"
                                                         name:@"MX-454"
                                                           ID:[NSNumber numberWithInt:3]
                                                    inContext:self.database.managedObjectContext]
                        inContext:self.database.managedObjectContext];
        [Child childWithFirstName:@"Stefani"
                         LastName:@"Germanotta"
                         uniqueID:[NSNumber numberWithInteger:7]
                           gender:@"Female"
                              dob:@"3/28/1986"
                          country:@"US"
                          address:@"50 Crazy blvd."
                             city:@"New York City"
                          picture:@"child.jpeg"
                           status:@"Active"
                         guardian:g4
             guardianRelationship:@"Uncle"
                          project:[Project projectWithAddress:@"11 main street"
                                                         name:@"US-0031"
                                                           ID:[NSNumber numberWithInt:4]
                                                    inContext:self.database.managedObjectContext]
                        inContext:self.database.managedObjectContext];
        
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

- (NSArray *)getChildrenWithParameters:(NSMutableDictionary *)parameters
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Child"];
    NSMutableArray *predicates = [[NSMutableArray alloc] init];
    for (NSString *key in parameters.keyEnumerator) {
        NSString *value = [parameters valueForKey:key];
        if (![value isEqualToString:@"All"]) {
            NSExpression *left = [NSExpression expressionForKeyPath:key];
            NSExpression *right = [NSExpression expressionForConstantValue:value];
            NSPredicate *predicate = [NSComparisonPredicate predicateWithLeftExpression:left rightExpression:right modifier:NSDirectPredicateModifier type:NSEqualToPredicateOperatorType options:0];
            [predicates addObject:predicate];
        }
    }
    
    NSPredicate *compound = [NSCompoundPredicate andPredicateWithSubpredicates:predicates];
    request.predicate = compound;
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
