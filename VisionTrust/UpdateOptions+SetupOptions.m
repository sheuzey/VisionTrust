//
//  UpdateOptions+SetupOptions.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/25/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "UpdateOptions+SetupOptions.h"

@implementation UpdateOptions (SetupOptions)

+ (UpdateOptions *)optionWithDescription:(NSString *)optionDescription
                                inUpdate:(Update *)update
                               inContext:(NSManagedObjectContext *)context
{
    UpdateOptions *option = [NSEntityDescription insertNewObjectForEntityForName:@"UpdateOptions"
                                                     inManagedObjectContext:context];
    option.updateOptionDescription = optionDescription;
    option.inUpdate = update;
    
    return option;
}

@end
