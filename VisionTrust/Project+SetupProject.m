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
                      inContext:(NSManagedObjectContext *)context
{
    Project *project = [NSEntityDescription insertNewObjectForEntityForName:@"Project"
                                             inManagedObjectContext:context];
    project.address = address;
    project.name = name;
    
    return project;
}

@end
