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
                     occupationType:(OccupationType *)type
                     guardianStatus:(GuardianStatus *)status
                          inContext:(NSManagedObjectContext *)context
{
    Guardian *guardian = [NSEntityDescription insertNewObjectForEntityForName:@"Guardian" inManagedObjectContext:context];
    guardian.firstName = fName;
    guardian.lastName = lName;
    guardian.hasOccupationType = type;
    guardian.hasGuardianStatus = status;

    return guardian;
}

@end
