//
//  Interactions+SetupInteraction.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/24/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "Interactions+SetupInteraction.h"

@implementation Interactions (SetupInteraction)

+ (Interactions *)interactionWithDepartureComments:(NSString *)dComments
                               departureReasonCode:(NSString *)code
                                     interactionID:(NSNumber *)unique
                                       isattending:(NSNumber *)attending
                                      pictureTaken:(NSNumber *)taken
                                      registeredBy:(NSString *)registerName
                                    chronicIllness:(NSString *)illness
                                    healthComments:(NSString *)hComments
                                receivingTreatment:(NSNumber *)treatment
                                  developmentLevel:(NSString *)level
                                   healthCondition:(NSString *)condition
                                    ifNotAttending:(NSString *)ifNot
                                     isHandicapped:(NSNumber *)handicapped
                                       schoolGrade:(NSString *)grade
                                     usSchoolGrade:(NSString *)usGrade
                                          forChild:(Child *)child
                                           byStaff:(User *)staff
                                       withUpdates:(NSSet *)updates
                                         inContext:(NSManagedObjectContext *)context
{
    Interactions *interaction = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Interaction"];
    request.predicate = [NSPredicate predicateWithFormat:@"unique = %d", unique];
    
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request error:&error];
    
    if([matches count] == 0) {
        interaction = [NSEntityDescription insertNewObjectForEntityForName:@"Interactions"
                                              inManagedObjectContext:context];
        
        interaction.departureComments = dComments;
        interaction.departureReasonCode = code;
        interaction.interactionID = unique;
        interaction.isAttending = attending;
        interaction.pictureTaken = taken;
        interaction.registeredBy = registerName;
        interaction.chronicIllness = illness;
        interaction.healthComments = hComments;
        interaction.currentlyReceivingTreatment = treatment;
        interaction.developmentLevel = level;
        interaction.healthCondition = condition;
        interaction.ifNotAttending = ifNot;
        interaction.isHandicapped = handicapped;
        interaction.schoolGrade = grade;
        interaction.usSchoolGrade = usGrade;
        interaction.child = child;
        interaction.staff = staff;
        interaction.updates = updates;
        
        interaction.interactionDate = [NSDate date];
        
    } else if([matches count] == 1) {
        interaction = [matches lastObject];
    }
    return interaction;
}

@end
