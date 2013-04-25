//
//  OptionCategories.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/25/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class UpdateOptions;

@interface OptionCategories : NSManagedObject

@property (nonatomic, retain) NSString * categoryDescription;
@property (nonatomic, retain) UpdateOptions *partOfOption;

@end
