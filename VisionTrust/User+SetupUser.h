//
//  User+SetupUser.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/12/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "User.h"

@interface User (SetupUser)

+ (User *)userWithUsername:(NSString *)username
               andPassword:(NSString *)password
              andFirstName:(NSString *)firstName
               andLastName:(NSString *)lastName
    inManagedObjectContext:(NSManagedObjectContext *)context;

@end
