//
//  Interactions.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/26/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Child, Update, User;

@interface Interactions : NSManagedObject

@property (nonatomic, retain) NSString * chronicIllness;
@property (nonatomic, retain) NSNumber * currentlyReceivingTreatment;
@property (nonatomic, retain) NSString * departureComments;
@property (nonatomic, retain) NSString * departureReasonCode;
@property (nonatomic, retain) NSString * developmentLevel;
@property (nonatomic, retain) NSString * healthComments;
@property (nonatomic, retain) NSString * healthCondition;
@property (nonatomic, retain) NSString * ifNotAttending;
@property (nonatomic, retain) NSDate * interactionDate;
@property (nonatomic, retain) NSNumber * isAttending;
@property (nonatomic, retain) NSNumber * isHandicapped;
@property (nonatomic, retain) NSNumber * pictureTaken;
@property (nonatomic, retain) NSString * registeredBy;
@property (nonatomic, retain) NSString * schoolGrade;
@property (nonatomic, retain) NSString * usSchoolGrade;
@property (nonatomic, retain) Child *child;
@property (nonatomic, retain) User *staff;
@property (nonatomic, retain) Update *update;

@end
