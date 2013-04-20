//
//  Child.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/20/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Guardian, Project;

@interface Child : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * dob;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSString * pictureURL;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * ts;
@property (nonatomic, retain) NSNumber * unique;
@property (nonatomic, retain) NSString * relationToGuardian;
@property (nonatomic, retain) Guardian *hasGuardian;
@property (nonatomic, retain) Project *isPartOfProject;

@end
