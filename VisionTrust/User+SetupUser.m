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
              andFirstName:(NSString *)firstName
               andLastName:(NSString *)lastName
    inManagedObjectContext:(NSManagedObjectContext *)context
{
    User *user = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    request.predicate = [NSPredicate predicateWithFormat:@"username = %@", username];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if([matches count] == 0) {
        user = [NSEntityDescription insertNewObjectForEntityForName:@"User"
                                             inManagedObjectContext:context];
        user.username = username;
        user.password = password;
        user.firstName = firstName;
        user.lastName = lastName;
        
    } else if([matches count] == 1) {
        user = [matches lastObject];
    }
    return user;
}

@end
