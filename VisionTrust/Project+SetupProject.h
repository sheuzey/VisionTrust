//
//  Project+SetupProject.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/19/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "Project.h"

@interface Project (SetupProject)

+ (Project *)projectWithAddress:(NSString *)address
                           name:(NSString *)name
                      inContext:(NSManagedObjectContext *)context;

@end
