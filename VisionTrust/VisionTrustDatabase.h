//
//  VisionTrustDatabase.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/18/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User+SetupUser.h"
#import "Child+SetupChild.h"
#import "Project+SetupProject.h"
#import "Guardian+SetupGuardian.h"
#import "GuardianStatus+SetuptGuardianStatus.h"
#import "OccupationType+SetupOccupationType.h"
#import "Interactions+SetupInteraction.h"


@interface VisionTrustDatabase : NSObject

- (User *)getUserByUsername:(NSString *)username;
- (NSArray *)getAllChildren;
- (NSMutableArray *)getChildrenWithParameters:(NSMutableDictionary *)parameters;
- (NSArray *)getAllProjects;
- (NSDictionary *)getAcademicDataFromInteraction:(Interactions *)interaction;

- (void)saveDatabase;
- (void)registerChildWithGeneralInfo:(NSMutableDictionary *)general
                          healthInfo:(NSMutableDictionary *)health
                        andGuardians:(NSSet *)guardians;

//Create singletone instance..
+ (VisionTrustDatabase *)vtDatabase;
@end
