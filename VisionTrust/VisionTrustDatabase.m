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

#define FIRST_NAME @"firstName"
#define LAST_NAME @"lastName"
#define GENDER @"gender"
#define DOB @"dob"
#define ADDRESS @"address"
#define CITY @"city"
#define COUNTRY @"country"
#define PROJECT @"project"
#define PICTURE_DATA @"pictureData"

#define HEALTH @"healthCondition"
#define TREATMENT @"currentlyReceivingTreatment"
#define ILLNESS @"chronicIllness"

#define OCCUPATION @"occupation"
#define STATUS @"status"

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
        OccupationType *t3 = [OccupationType typeWithDescription:@"Lawyer" inContext:self.database.managedObjectContext];
        OccupationType *t4 = [OccupationType typeWithDescription:@"Singer" inContext:self.database.managedObjectContext];
        OccupationType *t5 = [OccupationType typeWithDescription:@"Social Activist" inContext:self.database.managedObjectContext];
        
        //Create guardian status'..
        GuardianStatus *s1 = [GuardianStatus statusWithDescription:@"Full-Time" inContext:self.database.managedObjectContext];
        GuardianStatus *s2 = [GuardianStatus statusWithDescription:@"Part-Time" inContext:self.database.managedObjectContext];
        GuardianStatus *s3 = [GuardianStatus statusWithDescription:@"Unemployed" inContext:self.database.managedObjectContext];
        GuardianStatus *s4 = [GuardianStatus statusWithDescription:@"Seasonally Employed" inContext:self.database.managedObjectContext];
        
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
        
        //Create projects..
        Project *p1 = [Project projectWithAddress:@"50 project place"
                               name:@"DR-3320"
                                 ID:[NSNumber numberWithInt:1]
                          inContext:self.database.managedObjectContext];
        Project *p2 = [Project projectWithAddress:@"1 vision avenue"
                                             name:@"VEN-1099"
                                               ID:[NSNumber numberWithInt:2]
                                        inContext:self.database.managedObjectContext];
        Project *p3 = [Project projectWithAddress:@"23 trust blvd"
                                             name:@"MX-454"
                                               ID:[NSNumber numberWithInt:3]
                                        inContext:self.database.managedObjectContext];
        Project *p4 = [Project projectWithAddress:@"11 main street"
                                             name:@"US-0031"
                                               ID:[NSNumber numberWithInt:4]
                                        inContext:self.database.managedObjectContext];
        [Project projectWithAddress:@"45 2nd way"
                               name:@"BRZ-1324"
                                 ID:[NSNumber numberWithInt:4]
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
                      pictureData:nil
                           status:@"Active"
                        guardians:[[NSSet alloc] initWithObjects:g1, g2, nil]
                          project:p1
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
                      pictureData:nil
                           status:@"Active"
                        guardians:[[NSSet alloc] initWithObjects:g1, g2, nil]
                          project:p2
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
                      pictureData:nil         
                           status:@"Active"
                        guardians:[[NSSet alloc] initWithObjects:g3, g5, nil]
                          project:p3
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
                      pictureData:nil         
                           status:@"Inactive"
                        guardians:[[NSSet alloc] initWithObjects:g4, g5, nil]
                          project:p1
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
                      pictureData:nil         
                           status:@"Inactive"
                        guardians:[[NSSet alloc] initWithObjects:g2, g4, nil]
                          project:p2
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
                      pictureData:nil         
                           status:@"Active"
                        guardians:[[NSSet alloc] initWithObjects:g1, g5, nil]
                          project:p3
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
                      pictureData:nil         
                           status:@"Active"
                        guardians:[[NSSet alloc] initWithObjects:g2, g4, nil]
                          project:p4
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
        [self.database openWithCompletionHandler:nil];
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

- (NSArray *)getAllProjects
{
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Project"];
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
    [self.database closeWithCompletionHandler:^(BOOL sucess) {
        if (sucess)
            NSLog(@"DATABASE CLOSED!");
        else
            NSLog(@"Database didn't close..");
    }];
}

- (void)addInteractionForChild:(Child *)child
{
    
}

- (void)registerChildWithGeneralInfo:(NSMutableDictionary *)general
                          healthInfo:(NSMutableDictionary *)health
                        andGuardians:(NSSet *)guardians
{
    __block Child *child;
    [self.database.managedObjectContext performBlock:^{
        child = [Child childWithFirstName:[general valueForKey:FIRST_NAME]
                                 LastName:[general valueForKey:LAST_NAME]
                                 uniqueID:[NSNumber numberWithInt:10]
                                   gender:[general valueForKey:GENDER]
                                      dob:[general valueForKey:DOB]
                                  country:[general valueForKey:COUNTRY]
                                  address:[general valueForKey:ADDRESS]
                                     city:[general valueForKey:CITY]
                                  picture:nil
                              pictureData:[general valueForKey:PICTURE_DATA]
                                   status:[general valueForKey:STATUS]
                                guardians:guardians
                                  project:[general valueForKey:PROJECT]
                                inContext:self.database.managedObjectContext];
    }];
    [self addInteractionForChild:child];
}

+ (VisionTrustDatabase *)vtDatabase
{
    static VisionTrustDatabase *theOneAndOnly = NULL;
    
    @synchronized(self)
    {
        if (!theOneAndOnly) {
            theOneAndOnly = [[VisionTrustDatabase alloc] init];
        }
    }
    return theOneAndOnly;
}

@end
