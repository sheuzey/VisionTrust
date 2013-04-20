//
//  Guardian.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/20/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Child, GuardianStatus, OccupationType;

@interface Guardian : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSNumber * unique;
@property (nonatomic, retain) NSSet *guardianOf;
@property (nonatomic, retain) GuardianStatus *hasGuardianStatus;
@property (nonatomic, retain) OccupationType *hasOccupationType;
@end

@interface Guardian (CoreDataGeneratedAccessors)

- (void)addGuardianOfObject:(Child *)value;
- (void)removeGuardianOfObject:(Child *)value;
- (void)addGuardianOf:(NSSet *)values;
- (void)removeGuardianOf:(NSSet *)values;

@end
