//
//  Child+SetupChild.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/14/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "Child.h"
#import "Project.h"

@interface Child (SetupChild)

+ (Child *)childWithFirstName:(NSString *)fName
                     LastName:(NSString *)lName
                       gender:(NSString *)gender
                          dob:(NSString *)dob
                      country:(NSString *)country
                      address:(NSString *)address
                         city:(NSString *)city
                      picture:(NSString *)picture
                  pictureData:(NSData *)data
                       status:(NSString *)status
                     guardians:(NSSet *)guardians
                      project:(Project *)project
                    inContext:(NSManagedObjectContext *)context;

@end
