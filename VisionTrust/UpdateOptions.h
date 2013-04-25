//
//  UpdateOptions.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/25/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OptionCategories, Update;

@interface UpdateOptions : NSManagedObject

@property (nonatomic, retain) NSString * updateOptionDescription;
@property (nonatomic, retain) NSSet *hasCategories;
@property (nonatomic, retain) Update *inUpdate;
@end

@interface UpdateOptions (CoreDataGeneratedAccessors)

- (void)addHasCategoriesObject:(OptionCategories *)value;
- (void)removeHasCategoriesObject:(OptionCategories *)value;
- (void)addHasCategories:(NSSet *)values;
- (void)removeHasCategories:(NSSet *)values;

@end
