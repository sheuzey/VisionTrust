//
//  Guardian+SetupGuardian.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/20/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "Guardian.h"

@interface Guardian (SetupGuardian)

+ (Guardian *)guardianWithFirstName:(NSString *)fName
                           lastName:(NSString *)lName
                             unique:(NSNumber *)unique
                     occupationType:(OccupationType *)type
                     guardianStatus:(GuardianStatus *)status
                          inContext:(NSManagedObjectContext *)context;

@end
