//
//  Child.h
//  VisionTrust
//
//  Created by Programming on 4/17/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Guardian, GuardianStatus;

@interface Child : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSNumber * childID;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * dob;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSNumber * isActive;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * pictureURL;
@property (nonatomic, retain) NSString * ts;
@property (nonatomic, retain) GuardianStatus *guardianStatus;
@property (nonatomic, retain) Guardian *guardianType;

@end
