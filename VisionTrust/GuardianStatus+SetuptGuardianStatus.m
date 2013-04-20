//
//  GuardianStatus+SetuptGuardianStatus.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/20/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "GuardianStatus+SetuptGuardianStatus.h"

@implementation GuardianStatus (SetuptGuardianStatus)

+ (GuardianStatus *)statusWithDescription:(NSString *)descriptionOfStatus inContext:(NSManagedObjectContext *)context
{
    GuardianStatus *status = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"GuardianStatus"];
    request.predicate = [NSPredicate predicateWithFormat:@"guardianStatusDescription = %@", descriptionOfStatus];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if([matches count] == 0) {
        
        status = [NSEntityDescription insertNewObjectForEntityForName:@"GuardianStatus" inManagedObjectContext:context];
        status.guardianStatusDescription = descriptionOfStatus;
        
    } else if([matches count] == 1) {
        status = [matches lastObject];
    }
    return status;
}

@end
