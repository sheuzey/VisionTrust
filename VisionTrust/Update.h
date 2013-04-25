//
//  Update.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/25/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Interactions, UpdateOptions;

@interface Update : NSManagedObject

@property (nonatomic, retain) Interactions *inInteraction;
@property (nonatomic, retain) NSSet *hasUpdateOptions;
@end

@interface Update (CoreDataGeneratedAccessors)

- (void)addHasUpdateOptionsObject:(UpdateOptions *)value;
- (void)removeHasUpdateOptionsObject:(UpdateOptions *)value;
- (void)addHasUpdateOptions:(NSSet *)values;
- (void)removeHasUpdateOptions:(NSSet *)values;

@end
