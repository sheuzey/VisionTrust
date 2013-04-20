//
//  GuardianStatus+SetuptGuardianStatus.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/20/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "GuardianStatus.h"

@interface GuardianStatus (SetuptGuardianStatus)

+ (GuardianStatus *)statusWithDescription:(NSString *)descriptionOfStatus
                                inContext:(NSManagedObjectContext *)context;

@end
