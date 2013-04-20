//
//  Guardian+SetupGuardian.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/20/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "Guardian+SetupGuardian.h"

@implementation Guardian (SetupGuardian)

+ (Guardian *)guardianWithFirstName:(NSString *)fName
                           lastName:(NSString *)lName
                             unique:(NSNumber *)unique
                     occupationType:(OccupationType *)type
                     guardianStatus:(GuardianStatus *)status
                          inContext:(NSManagedObjectContext *)context
{
    Guardian *guardian = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Guardian"];
    request.predicate = [NSPredicate predicateWithFormat:@"unique = %@", unique];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if([matches count] == 0) {
        
        guardian = [NSEntityDescription insertNewObjectForEntityForName:@"Guardian" inManagedObjectContext:context];
        guardian.firstName = fName;
        guardian.lastName = lName;
        guardian.unique = unique;
        guardian.hasOccupationType = type;
        guardian.hasGuardianStatus = status;
        
    } else if([matches count] == 1) {
        guardian = [matches lastObject];
    }
    return guardian;
}

@end
