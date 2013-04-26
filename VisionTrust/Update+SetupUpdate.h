//
//  Update+SetupUpdate.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/25/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "Update.h"

@interface Update (SetupUpdate)

+ (Update *)updateInInteraction:(Interactions *)interaction
                      inContext:(NSManagedObjectContext *)context;

@end
