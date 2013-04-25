//
//  Child.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/25/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Guardian, Interactions, Project;

@interface Child : NSManagedObject

@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * city;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSString * dob;
@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * gender;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSData * pictureData;
@property (nonatomic, retain) NSString * pictureURL;
@property (nonatomic, retain) NSString * status;
@property (nonatomic, retain) NSString * ts;
@property (nonatomic, retain) NSSet *hasGuardians;
@property (nonatomic, retain) NSSet *interactions;
@property (nonatomic, retain) Project *isPartOfProject;
@end

@interface Child (CoreDataGeneratedAccessors)

- (void)addHasGuardiansObject:(Guardian *)value;
- (void)removeHasGuardiansObject:(Guardian *)value;
- (void)addHasGuardians:(NSSet *)values;
- (void)removeHasGuardians:(NSSet *)values;

- (void)addInteractionsObject:(Interactions *)value;
- (void)removeInteractionsObject:(Interactions *)value;
- (void)addInteractions:(NSSet *)values;
- (void)removeInteractions:(NSSet *)values;

@end
