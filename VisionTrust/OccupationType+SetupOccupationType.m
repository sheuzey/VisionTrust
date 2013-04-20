//
//  OccupationType+SetupOccupationType.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/20/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "OccupationType+SetupOccupationType.h"

@implementation OccupationType (SetupOccupationType)

+ (OccupationType *)typeWithDescription:(NSString *)descriptionOfOccupation inContext:(NSManagedObjectContext *)context
{
    OccupationType *type = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"OccupationType"];
    request.predicate = [NSPredicate predicateWithFormat:@"occupationTypeDescription = %@", descriptionOfOccupation];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if([matches count] == 0) {
        
        type = [NSEntityDescription insertNewObjectForEntityForName:@"OccupationType" inManagedObjectContext:context];
        type.occupationTypeDescription = descriptionOfOccupation;
        
    } else if([matches count] == 1) {
        type = [matches lastObject];
    }
    return type;
}

@end
