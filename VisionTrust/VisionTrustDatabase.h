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
#import "Update+SetupUpdate.h"
#import "UpdateOptions+SetupOptions.h"
#import "OptionCategories+SetupCategories.h"

@interface VisionTrustDatabase : NSObject

- (User *)getUserByUsername:(NSString *)username;
- (NSArray *)getAllChildren;
- (NSMutableArray *)getChildrenWithParameters:(NSMutableDictionary *)parameters;
- (NSArray *)getAllProjects;

- (void)saveDatabase;
- (void)registerChildWithGeneralInfo:(NSMutableDictionary *)general
                          healthInfo:(NSMutableDictionary *)health
                        andGuardians:(NSSet *)guardians;

- (OccupationType *)getOccupationTypeWithStatus:(NSString *)status;

- (GuardianStatus *)getGuardianStatusWithStatus:(NSString *)status;

- (void)removeGuardian:(Guardian *)guardian
             fromChild:(Child *)child;

- (void)addGuardianFromInfo:(NSMutableDictionary *)info
                         forChild:(Child *)child;

- (void)updateChild:(Child *)child
      withGuardians:(NSMutableArray *)guardians
withUpdatdedProject:(NSString *)projectName
   WithAcademicData:(NSMutableDictionary *)academicData
         healthData:(NSMutableDictionary *)healthData
      spiritualData:(NSMutableDictionary *)spiritualData
        andHomeData:(NSMutableDictionary *)homeData;

//Create singletone instance..
+ (VisionTrustDatabase *)vtDatabase;
@end
