//
//  Update+SetupUpdate.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/25/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "Update+SetupUpdate.h"

@implementation Update (SetupUpdate)

+ (Update *)updateInInteraction:(Interactions *)interaction
          withUpdateDescription:(NSString *)updateDescription
                      inContext:(NSManagedObjectContext *)context;
{
    Update *update = [NSEntityDescription insertNewObjectForEntityForName:@"Update"
                                                     inManagedObjectContext:context];
    update.inInteraction = interaction;
    update.updateDescription = updateDescription;
    
    return update;
}

@end
