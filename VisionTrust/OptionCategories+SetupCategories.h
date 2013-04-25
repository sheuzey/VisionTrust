//
//  OptionCategories+SetupCategories.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/25/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "OptionCategories.h"

@interface OptionCategories (SetupCategories)

+ (OptionCategories *)categoryWithDescription:(NSString *)catDescription
                                     inOption:(UpdateOptions *)option
                                    inContext:(NSManagedObjectContext *)context;

@end
