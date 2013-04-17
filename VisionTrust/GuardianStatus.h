//
//  GuardianStatus.h
//  VisionTrust
//
//  Created by Programming on 4/17/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Guardian;

@interface GuardianStatus : NSManagedObject

@property (nonatomic, retain) NSString * guardianStatusDescription;
@property (nonatomic, retain) NSSet *guardianStatusOf;
@end

@interface GuardianStatus (CoreDataGeneratedAccessors)

- (void)addGuardianStatusOfObject:(Guardian *)value;
- (void)removeGuardianStatusOfObject:(Guardian *)value;
- (void)addGuardianStatusOf:(NSSet *)values;
- (void)removeGuardianStatusOf:(NSSet *)values;

@end
