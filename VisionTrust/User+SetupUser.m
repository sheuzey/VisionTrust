//
//  User+SetupUser.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/12/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "User+SetupUser.h"

@implementation User (SetupUser)

+ (User *)userWithUsername:(NSString *)username
               andPassword:(NSString *)password
    inManagedObjectContext:(NSManagedObjectContext *)context
{
    User *user = nil;
    user = [NSEntityDescription insertNewObjectForEntityForName:@"User"
                                         inManagedObjectContext:context];
    user.username = username;
    user.password = password;
    return user;
}

@end
