//
//  Interactions+SetupInteraction.h
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/24/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "Interactions.h"

@interface Interactions (SetupInteraction)

+ (Interactions *)interactionWithDepartureComments:(NSString *)dComments
                               departureReasonCode:(NSString *)code
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
                                        isBaptized:(NSString *)baptized
                                           isSaved:(NSString *)saved
                                 spiritualProgress:(NSString *)progress
                                          forChild:(Child *)child
                                           byStaff:(User *)staff
                                         inContext:(NSManagedObjectContext *)context;


@end
