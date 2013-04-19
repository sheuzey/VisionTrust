//
//  Project.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/18/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Child;

@interface Project : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * unique;
@property (nonatomic, retain) NSSet *hasChildren;
@end

@interface Project (CoreDataGeneratedAccessors)

- (void)addHasChildrenObject:(Child *)value;
- (void)removeHasChildrenObject:(Child *)value;
- (void)addHasChildren:(NSSet *)values;
- (void)removeHasChildren:(NSSet *)values;

@end
