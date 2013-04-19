//
//  Project+SetupProject.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/19/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "Project+SetupProject.h"

@implementation Project (SetupProject)

+ (Project *)projectWithAddress:(NSString *)address
                           name:(NSString *)name
                             ID:(NSNumber *)unique
                      inContext:(NSManagedObjectContext *)context
{
    Project *project = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Project"];
    request.predicate = [NSPredicate predicateWithFormat:@"unique = %d", unique];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if([matches count] == 0) {
        project = [NSEntityDescription insertNewObjectForEntityForName:@"Project"
                                             inManagedObjectContext:context];
        project.address = address;
        project.name = name;
        project.unique = unique;
        
    } else if([matches count] == 1) {
        project = [matches lastObject];
    }
    return project;
}

@end
