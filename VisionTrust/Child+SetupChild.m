//
//  Child+SetupChild.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/14/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "Child+SetupChild.h"

@implementation Child (SetupChild)

+ (Child *)childWithFirstName:(NSString *)fName
                     LastName:(NSString *)lName
                     uniqueID:(NSNumber *)ID
                       gender:(NSString *)gender
                          dob:(NSString *)dob
                      country:(NSString *)country
                      address:(NSString *)address
                         city:(NSString *)city
                      picture:(NSString *)picture
                       status:(NSString *)status
                      project:(Project *)project
                    inContext:(NSManagedObjectContext *)context
{
    Child *child = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Child"];
    request.predicate = [NSPredicate predicateWithFormat:@"unique = %d", ID];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if([matches count] == 0) {
        child = [NSEntityDescription insertNewObjectForEntityForName:@"Child"
                                             inManagedObjectContext:context];
        child.firstName = fName;
        child.lastName = lName;
        child.unique = ID;
        child.gender = gender;
        child.dob = dob;
        child.country = country;
        child.address = address;
        child.city = city;
        child.pictureURL = picture;
        child.status = status;
        child.isPartOfProject = project;
        
        NSDate *now = [NSDate date];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateStyle:NSDateFormatterFullStyle];
        [dateFormat setTimeStyle:NSDateFormatterFullStyle];
        child.ts = [dateFormat stringFromDate:now];
        
    } else if([matches count] == 1) {
        child = [matches lastObject];
    }
    return child;
}

@end
