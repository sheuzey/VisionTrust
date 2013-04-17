//
//  OccupationType.h
//  VisionTrust
//
//  Created by Programming on 4/17/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Guardian;

@interface OccupationType : NSManagedObject

@property (nonatomic, retain) NSString * occupationTypeDescription;
@property (nonatomic, retain) NSSet *occupationTypeOf;
@end

@interface OccupationType (CoreDataGeneratedAccessors)

- (void)addOccupationTypeOfObject:(Guardian *)value;
- (void)removeOccupationTypeOfObject:(Guardian *)value;
- (void)addOccupationTypeOf:(NSSet *)values;
- (void)removeOccupationTypeOf:(NSSet *)values;

@end
