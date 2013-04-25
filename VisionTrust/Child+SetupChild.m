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
                       gender:(NSString *)gender
                          dob:(NSString *)dob
                      country:(NSString *)country
                      address:(NSString *)address
                         city:(NSString *)city
                      picture:(NSString *)picture
                  pictureData:(NSData *)data
                       status:(NSString *)status
                     guardians:(NSSet *)guardians
                      project:(Project *)project
                    inContext:(NSManagedObjectContext *)context
{
    Child *child = [NSEntityDescription insertNewObjectForEntityForName:@"Child"
                                             inManagedObjectContext:context];
    child.firstName = fName;
    child.lastName = lName;
    child.gender = gender;
    child.dob = dob;
    child.country = country;
    child.address = address;
    child.city = city;
    child.pictureURL = picture;
    child.pictureData = data;
    child.status = status;
    child.hasGuardians = guardians;
    child.isPartOfProject = project;
    
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateStyle:NSDateFormatterFullStyle];
    [dateFormat setTimeStyle:NSDateFormatterFullStyle];
    child.ts = [dateFormat stringFromDate:now];
    
    return child;
}

@end
