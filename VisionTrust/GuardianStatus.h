//
//  GuardianStatus.h
//  VisionTrust
//
//  Created by Programming on 4/17/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Child;

@interface GuardianStatus : NSManagedObject

@property (nonatomic, retain) NSSet *guardianOf;
@end

@interface GuardianStatus (CoreDataGeneratedAccessors)

- (void)addGuardianOfObject:(Child *)value;
- (void)removeGuardianOfObject:(Child *)value;
- (void)addGuardianOf:(NSSet *)values;
- (void)removeGuardianOf:(NSSet *)values;

@end
