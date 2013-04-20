//
//  OccupationType+SetupOccupationType.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/20/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "OccupationType.h"

@interface OccupationType (SetupOccupationType)

+ (OccupationType *)typeWithDescription:(NSString *)descriptionOfOccupation
                              inContext:(NSManagedObjectContext *)context;

@end
