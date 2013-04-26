//
//  UpdateOptions+SetupOptions.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/25/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "UpdateOptions.h"

@interface UpdateOptions (SetupOptions)

+ (UpdateOptions *)optionWithDescription:(NSString *)optionDescription
                                inUpdate:(Update *)update
                               inContext:(NSManagedObjectContext *)context;

@end
