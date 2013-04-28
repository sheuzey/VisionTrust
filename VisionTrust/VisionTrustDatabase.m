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

#define OCCUPATION @"occupation"
#define STATUS @"status"

#define HEALTH @"healthCondition"
#define TREATMENT @"currentlyReceivingTreatment"
#define ILLNESS @"chronicIllness"
#define HEALTH_COMMENTS @"healthComments"

#define ACADEMIC_OPTION @"Academic"
#define GRADE @"currentGrade"
#define DEVELOPMENT_LEVEL @"developmentLevel"
#define FAVORITE_SUBJECTS @"favoriteSubjects"

#define HOMELIFE_OPTION @"Home Life"
#define FAVORITE_ACTIVITIES @"favoriteActivities"
#define HOME_CHORES @"homeChores"
#define PERSONALITY @"personalityTraits"
#define ADDITIONAL_COMMENTS @"additionalComments"

#define SPIRITUAL_OPTION @"Spiritual"
#define BAPTISM @"baptism"
#define SALVATION @"salvation"
#define SPIRITUAL_ACTIVITIES @"spiritualActivities"
#define PROGRESS @"progress"

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
                                        occupationType:t1
                                        guardianStatus:s2
                                             inContext:self.database.managedObjectContext];
        Guardian *g2 = [Guardian guardianWithFirstName:@"Lisa"
                                              lastName:@"Chavez"
                                        occupationType:t5
                                        guardianStatus:s1
                                             inContext:self.database.managedObjectContext];
        Guardian *g3 = [Guardian guardianWithFirstName:@"Stuart"
                                              lastName:@"Un"
                                        occupationType:t4
                                        guardianStatus:s4
                                             inContext:self.database.managedObjectContext];
        Guardian *g4 = [Guardian guardianWithFirstName:@"Dmitri"
                                              lastName:@"Putin"
                                        occupationType:t2
                                        guardianStatus:s3
                                             inContext:self.database.managedObjectContext];
        Guardian *g5 = [Guardian guardianWithFirstName:@"Caroline"
                                              lastName:@"Smith"
                                        occupationType:t3
                                        guardianStatus:s1
                                             inContext:self.database.managedObjectContext];
        
        //Create projects..
        Project *p1 = [Project projectWithAddress:@"50 project place"
                               name:@"DR-3320"
                          inContext:self.database.managedObjectContext];
        Project *p2 = [Project projectWithAddress:@"1 vision avenue"
                                             name:@"VEN-1099"
                                        inContext:self.database.managedObjectContext];
        Project *p3 = [Project projectWithAddress:@"23 trust blvd"
                                             name:@"MX-454"
                                        inContext:self.database.managedObjectContext];
        Project *p4 = [Project projectWithAddress:@"11 main street"
                                             name:@"US-0031"
                                        inContext:self.database.managedObjectContext];
        [Project projectWithAddress:@"45 2nd way"
                               name:@"BRZ-1324"
                          inContext:self.database.managedObjectContext];
        
        //Add children with projects..
        Child *c1 = [Child childWithFirstName:@"Julio"
                                     LastName:@"Gonzalas"
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
        
        Child *c2 = [Child childWithFirstName:@"Hugo"
                                     LastName:@"Chavez"
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
        
        Child *c3 = [Child childWithFirstName:@"Kim Jong"
                                     LastName:@"Un"
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
        
        Child *c4 = [Child childWithFirstName:@"Katie"
                                     LastName:@"Smith"
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
        
        Child *c5 = [Child childWithFirstName:@"Vladimir"
                                     LastName:@"Putin"
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
        
        Child *c6 = [Child childWithFirstName:@"William"
                                     LastName:@"Brown"
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
        
        Child *c7 = [Child childWithFirstName:@"Stefani"
                                     LastName:@"Germanotta"
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
        
        //Add sample registrations for children..
        [Interactions interactionWithDepartureComments:nil
                                   departureReasonCode:nil
                                           isattending:[NSNumber numberWithInt:1]
                                          pictureTaken:nil
                                          registeredBy:nil
                                        chronicIllness:nil
                                        healthComments:nil
                                    receivingTreatment:nil
                                      developmentLevel:nil
                                       healthCondition:nil
                                        ifNotAttending:nil
                                         isHandicapped:nil
                                           schoolGrade:nil
                                         usSchoolGrade:nil
                                            isBaptized:nil
                                               isSaved:nil
                                     spiritualProgress:nil
                                              forChild:c1
                                               byStaff:nil
                                             inContext:self.database.managedObjectContext];
        
        [Interactions interactionWithDepartureComments:nil
                                   departureReasonCode:nil
                                           isattending:[NSNumber numberWithInt:1]
                                          pictureTaken:nil
                                          registeredBy:nil
                                        chronicIllness:nil
                                        healthComments:nil
                                    receivingTreatment:nil
                                      developmentLevel:nil
                                       healthCondition:nil
                                        ifNotAttending:nil
                                         isHandicapped:nil
                                           schoolGrade:nil
                                         usSchoolGrade:nil
                                            isBaptized:nil
                                               isSaved:nil
                                     spiritualProgress:nil
                                              forChild:c2
                                               byStaff:nil
                                             inContext:self.database.managedObjectContext];
        
        [Interactions interactionWithDepartureComments:nil
                                   departureReasonCode:nil
                                           isattending:[NSNumber numberWithInt:1]
                                          pictureTaken:nil
                                          registeredBy:nil
                                        chronicIllness:nil
                                        healthComments:nil
                                    receivingTreatment:nil
                                      developmentLevel:nil
                                       healthCondition:nil
                                        ifNotAttending:nil
                                         isHandicapped:nil
                                           schoolGrade:nil
                                         usSchoolGrade:nil
                                            isBaptized:nil
                                               isSaved:nil
                                     spiritualProgress:nil
                                              forChild:c3
                                               byStaff:nil
                                             inContext:self.database.managedObjectContext];
        
        [Interactions interactionWithDepartureComments:nil
                                   departureReasonCode:nil
                                           isattending:[NSNumber numberWithInt:1]
                                          pictureTaken:nil
                                          registeredBy:nil
                                        chronicIllness:nil
                                        healthComments:nil
                                    receivingTreatment:nil
                                      developmentLevel:nil
                                       healthCondition:nil
                                        ifNotAttending:nil
                                         isHandicapped:nil
                                           schoolGrade:nil
                                         usSchoolGrade:nil
                                            isBaptized:nil
                                               isSaved:nil
                                     spiritualProgress:nil
                                              forChild:c4
                                               byStaff:nil
                                             inContext:self.database.managedObjectContext];
        
        [Interactions interactionWithDepartureComments:nil
                                   departureReasonCode:nil
                                           isattending:[NSNumber numberWithInt:1]
                                          pictureTaken:nil
                                          registeredBy:nil
                                        chronicIllness:nil
                                        healthComments:nil
                                    receivingTreatment:nil
                                      developmentLevel:nil
                                       healthCondition:nil
                                        ifNotAttending:nil
                                         isHandicapped:nil
                                           schoolGrade:nil
                                         usSchoolGrade:nil
                                            isBaptized:nil
                                               isSaved:nil
                                     spiritualProgress:nil
                                              forChild:c5
                                               byStaff:nil
                                             inContext:self.database.managedObjectContext];
        
        [Interactions interactionWithDepartureComments:nil
                                   departureReasonCode:nil
                                           isattending:[NSNumber numberWithInt:1]
                                          pictureTaken:nil
                                          registeredBy:nil
                                        chronicIllness:nil
                                        healthComments:nil
                                    receivingTreatment:nil
                                      developmentLevel:nil
                                       healthCondition:nil
                                        ifNotAttending:nil
                                         isHandicapped:nil
                                           schoolGrade:nil
                                         usSchoolGrade:nil
                                            isBaptized:nil
                                               isSaved:nil
                                     spiritualProgress:nil
                                              forChild:c6
                                               byStaff:nil
                                             inContext:self.database.managedObjectContext];
        
        [Interactions interactionWithDepartureComments:nil
                                   departureReasonCode:nil
                                           isattending:[NSNumber numberWithInt:1]
                                          pictureTaken:nil
                                          registeredBy:nil
                                        chronicIllness:nil
                                        healthComments:nil
                                    receivingTreatment:nil
                                      developmentLevel:nil
                                       healthCondition:nil
                                        ifNotAttending:nil
                                         isHandicapped:nil
                                           schoolGrade:nil
                                         usSchoolGrade:nil
                                            isBaptized:nil
                                               isSaved:nil
                                     spiritualProgress:nil
                                              forChild:c7
                                               byStaff:nil
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

- (void)registerChildWithGeneralInfo:(NSMutableDictionary *)general
                          healthInfo:(NSMutableDictionary *)health
                        andGuardians:(NSSet *)guardians
{
    [self.database.managedObjectContext performBlock:^{
        //For each guardian dictionary in guardian set, create/get and add to final array. Create NSSet from final array..
        NSMutableArray *gArray = [[NSMutableArray alloc] init];
        for (NSMutableDictionary *dict in guardians) {
            
            //Create guardian occupation..
            OccupationType *occupation = [OccupationType typeWithDescription:[dict valueForKey:OCCUPATION] inContext:self.database.managedObjectContext];
            
            //And status..
            GuardianStatus *status = [GuardianStatus statusWithDescription:[dict valueForKey:STATUS] inContext:self.database.managedObjectContext];
            
            Guardian *temp = [Guardian guardianWithFirstName:[dict valueForKey:FIRST_NAME]
                                                    lastName:[dict valueForKey:LAST_NAME]
                                              occupationType:occupation
                                              guardianStatus:status
                                                   inContext:self.database.managedObjectContext];
            [gArray addObject:temp];
        }
        NSSet *allGuardians = [[NSSet alloc] initWithArray:gArray];
        
        //Get treament number from text..
        NSNumber *treatment;
        if ([[health valueForKey:TREATMENT] isEqualToString:@"Yes"])
            treatment = [NSNumber numberWithInt:1];
        else
            treatment = [NSNumber numberWithInt:0];
        
        //Create child..
        Child *child = [Child childWithFirstName:[general valueForKey:FIRST_NAME]
                                        LastName:[general valueForKey:LAST_NAME]
                                          gender:[general valueForKey:GENDER]
                                             dob:[general valueForKey:DOB]
                                         country:[general valueForKey:COUNTRY]
                                         address:[general valueForKey:ADDRESS]
                                            city:[general valueForKey:CITY]
                                         picture:nil
                                     pictureData:[general valueForKey:PICTURE_DATA]
                                          status:[general valueForKey:STATUS]
                                       guardians:allGuardians
                                         project:[Project projectWithAddress:[general valueForKey:ADDRESS]
                                                                        name:[general valueForKey:PROJECT]
                                                                   inContext:self.database.managedObjectContext]
                                       inContext:self.database.managedObjectContext];
        
        //Set NSNumber for pictureTaken..
        NSNumber *taken;
        if (child.pictureData)
            taken = [[NSNumber alloc] initWithInt:1];
        else
            taken = [[NSNumber alloc] initWithInt:0];
        
        [Interactions interactionWithDepartureComments:nil
                                   departureReasonCode:nil
                                           isattending:[NSNumber numberWithInt:1]
                                          pictureTaken:taken
                                          registeredBy:nil
                                        chronicIllness:[health valueForKey:ILLNESS]
                                        healthComments:[health valueForKey:HEALTH_COMMENTS]
                                    receivingTreatment:treatment
                                      developmentLevel:nil
                                       healthCondition:[health valueForKey:HEALTH]
                                        ifNotAttending:nil
                                         isHandicapped:nil
                                           schoolGrade:nil
                                         usSchoolGrade:nil
                                            isBaptized:nil
                                               isSaved:nil
                                     spiritualProgress:nil
                                              forChild:child
                                               byStaff:nil
                                             inContext:self.database.managedObjectContext];
    }];
}

- (void)updateChild:(Child *)child
   WithAcademicData:(NSMutableDictionary *)academicData
         healthData:(NSMutableDictionary *)healthData
      spiritualData:(NSMutableDictionary *)spiritualData
        andHomeData:(NSMutableDictionary *)homeData
{
    [self.database.managedObjectContext performBlock:^{
        
        //Create an Interaction
        
        //Get treament number from text..
        NSNumber *treatment;
        if ([[healthData valueForKey:TREATMENT] isEqualToString:@"Yes"])
            treatment = [NSNumber numberWithInt:1];
        else
            treatment = [NSNumber numberWithInt:0];
        
        //Set NSNumber for pictureTaken..
        NSNumber *taken;
        if (child.pictureData)
            taken = [[NSNumber alloc] initWithInt:1];
        else
            taken = [[NSNumber alloc] initWithInt:0];
        
        Interactions *interaction = [Interactions interactionWithDepartureComments:nil
                                                               departureReasonCode:nil
                                                                       isattending:[NSNumber numberWithInt:1]
                                                                      pictureTaken:taken
                                                                      registeredBy:nil
                                                                    chronicIllness:[healthData valueForKey:ILLNESS]
                                                                    healthComments:[healthData valueForKey:HEALTH_COMMENTS]
                                                                receivingTreatment:treatment
                                                                  developmentLevel:[academicData valueForKey:DEVELOPMENT_LEVEL]
                                                                   healthCondition:[healthData valueForKey:HEALTH]
                                                                    ifNotAttending:nil
                                                                     isHandicapped:nil
                                                                       schoolGrade:[academicData valueForKey:GRADE]
                                                                     usSchoolGrade:[academicData valueForKey:GRADE]
                                                                        isBaptized:[spiritualData valueForKey:BAPTISM]
                                                                           isSaved:[spiritualData valueForKey:SALVATION]
                                                                 spiritualProgress:[spiritualData valueForKey:PROGRESS]
                                                                          forChild:child
                                                                           byStaff:nil
                                                                         inContext:self.database.managedObjectContext];
        //Add updates to Interaction..
        Update *academicUpdate = [Update updateInInteraction:interaction
                                       withUpdateDescription:ACADEMIC_OPTION inContext:self.database.managedObjectContext];
        Update *spiritualUpdate = [Update updateInInteraction:interaction
                                        withUpdateDescription:SPIRITUAL_OPTION inContext:self.database.managedObjectContext];
        Update *homeLifeUpdate = [Update updateInInteraction:interaction
                                       withUpdateDescription:HOMELIFE_OPTION inContext:self.database.managedObjectContext];
        
        //Add update options to update..
        UpdateOptions *academicOptions;
        UpdateOptions *spiritualOptions;
        UpdateOptions *commentsOption;
        UpdateOptions *choresOption;
        UpdateOptions *activitiesOption;
        UpdateOptions *personalityOption;
        if (academicData) {
            academicOptions = [UpdateOptions optionWithDescription:ACADEMIC_OPTION
                                                          inUpdate:academicUpdate inContext:self.database.managedObjectContext];
            
            //Create OptionCategories for academicData..
            NSArray *favoriteSubjects = [[NSArray alloc] initWithArray:[academicData valueForKey:FAVORITE_SUBJECTS]];
            for (NSString *subject in favoriteSubjects) {
                if ([subject length] > 0)
                    [OptionCategories categoryWithDescription:subject
                                                     inOption:academicOptions inContext:self.database.managedObjectContext];
            }
        }
        if (spiritualData) {
            spiritualOptions = [UpdateOptions optionWithDescription:SPIRITUAL_OPTION
                                                           inUpdate:spiritualUpdate inContext:self.database.managedObjectContext];
            
            //Create OptionCategories for spiritualData..
            //Add all spiritual activities..
            for (NSString *activity in [spiritualData valueForKey:SPIRITUAL_ACTIVITIES]) {
                if ([activity length] > 0)
                    [OptionCategories categoryWithDescription:activity
                                                     inOption:spiritualOptions
                                                    inContext:self.database.managedObjectContext];
            }
        }
        if (homeData) {
            commentsOption = [UpdateOptions optionWithDescription:ADDITIONAL_COMMENTS
                                                      inUpdate:homeLifeUpdate inContext:self.database.managedObjectContext];
            
            //Create OptionCategories for each option..
            //Add additional comments if exists..
            if ([homeData valueForKey:ADDITIONAL_COMMENTS])
                [OptionCategories categoryWithDescription:[homeData valueForKey:ADDITIONAL_COMMENTS]
                                                 inOption:commentsOption inContext:self.database.managedObjectContext];
            
            //Add all home chores..
            choresOption = [UpdateOptions optionWithDescription:HOME_CHORES
                                                       inUpdate:homeLifeUpdate inContext:self.database.managedObjectContext];
            
            for (NSString *chores in [homeData valueForKey:HOME_CHORES]) {
                if ([chores length] > 0)
                    [OptionCategories categoryWithDescription:chores
                                                     inOption:choresOption inContext:self.database.managedObjectContext];
            }
            
            //Add all favorite activities..
            activitiesOption = [UpdateOptions optionWithDescription:FAVORITE_ACTIVITIES
                                                           inUpdate:homeLifeUpdate inContext:self.database.managedObjectContext];
            
            for (NSString *activity in [homeData valueForKey:FAVORITE_ACTIVITIES]) {
                if ([activity length] > 0)
                    [OptionCategories categoryWithDescription:activity
                                                     inOption:activitiesOption inContext:self.database.managedObjectContext];
            }
            
            //Add all personality traits..
            personalityOption = [UpdateOptions optionWithDescription:PERSONALITY
                                                            inUpdate:homeLifeUpdate inContext:self.database.managedObjectContext];
            
            for (NSString *trait in [homeData valueForKey:PERSONALITY]) {
                if ([trait length] > 0)
                    [OptionCategories categoryWithDescription:trait
                                                     inOption:personalityOption inContext:self.database.managedObjectContext];
            }
        }
    }];
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
