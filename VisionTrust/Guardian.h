//
//  Guardian.h
//  VisionTrust
//
//  Created by Programming on 4/17/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Child, GuardianStatus, OccupationType;

@interface Guardian : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * relationToChild;
@property (nonatomic, retain) NSString * occupation;
@property (nonatomic, retain) NSSet *guardianOf;
@property (nonatomic, retain) OccupationType *hasOccupationType;
@property (nonatomic, retain) GuardianStatus *hasGuardianStatus;
@end

@interface Guardian (CoreDataGeneratedAccessors)

- (void)addGuardianOfObject:(Child *)value;
- (void)removeGuardianOfObject:(Child *)value;
- (void)addGuardianOf:(NSSet *)values;
- (void)removeGuardianOf:(NSSet *)values;

@end
