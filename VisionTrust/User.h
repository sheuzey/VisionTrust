//
//  User.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/13/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface User : NSManagedObject

@property (nonatomic, retain) NSString * password;
@property (nonatomic, retain) NSString * username;

@end
