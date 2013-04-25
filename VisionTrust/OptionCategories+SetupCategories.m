//
//  OptionCategories+SetupCategories.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/25/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "OptionCategories+SetupCategories.h"

@implementation OptionCategories (SetupCategories)

+ (OptionCategories *)categoryWithDescription:(NSString *)catDescription
                                     inOption:(UpdateOptions *)option
                                    inContext:(NSManagedObjectContext *)context
{
    OptionCategories *category = [NSEntityDescription insertNewObjectForEntityForName:@"OptionCategories"
                                                     inManagedObjectContext:context];
    category.categoryDescription = catDescription;
    category.partOfOption = option;
    
    return category;
}

@end
