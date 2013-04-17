//
//  UserType.h
//  VisionTrust
//
//  Created by Programming on 4/17/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class User;

@interface UserType : NSManagedObject

@property (nonatomic, retain) NSString * staffDescription;
@property (nonatomic, retain) NSSet *heldBy;
@end

@interface UserType (CoreDataGeneratedAccessors)

- (void)addHeldByObject:(User *)value;
- (void)removeHeldByObject:(User *)value;
- (void)addHeldBy:(NSSet *)values;
- (void)removeHeldBy:(NSSet *)values;

@end
