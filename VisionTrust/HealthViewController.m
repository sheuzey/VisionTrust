//
//  HealthViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/27/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "HealthViewController.h"

@interface HealthViewController ()
@property (nonatomic, strong) Interactions *latestInteraction;
@end

@implementation HealthViewController

#define HEALTH @"healthCondition"
#define TREATMENT @"currentlyReceivingTreatment"
#define ILLNESS @"chronicIllness"
#define HEALTH_COMMENTS @"healthComments"

- (void)viewDidLoad
{
    [super viewDidLoad];

    //Get latest interaction..
    NSArray *interactions = [self.child.interactions allObjects];
    for (Interactions *i in interactions) {
        if (([self.latestInteraction.interactionDate compare:i.interactionDate] == NSOrderedAscending) || !self.latestInteraction) {
            self.latestInteraction = i;
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    // Configure the cell...
    //If a health category is null, output 'No record'..
    switch ([indexPath section]) {
        case 0:
            switch ([indexPath row]) {
                case 0:
                    cell.textLabel.text = @"Health";
                    if (self.latestInteraction.healthCondition)
                        cell.detailTextLabel.text = self.latestInteraction.healthCondition;
                    else
                        cell.detailTextLabel.text = @"No record";
                    break;
                case 1:
                    cell.textLabel.text = @"Medical Treatment";
                    if (self.latestInteraction.currentlyReceivingTreatment == [NSNumber numberWithInt:0])
                        cell.detailTextLabel.text = @"No";
                    else if (self.latestInteraction.currentlyReceivingTreatment == [NSNumber numberWithInt:1])
                        cell.detailTextLabel.text = @"Yes";
                    else
                        cell.detailTextLabel.text = @"No record";
                    break;
            }
            break;
        case 1:
            switch ([indexPath row]) {
                case 0:
                    cell.textLabel.text = @"Illness";
                    if (self.latestInteraction.chronicIllness)
                        cell.detailTextLabel.text = self.latestInteraction.chronicIllness;
                    else
                        cell.detailTextLabel.text = @"No record";
                    break;
                case 1:
                    cell.textLabel.text = @"Other Comments";
                    if (self.latestInteraction.healthComments)
                        cell.detailTextLabel.text = self.latestInteraction.healthComments;
                    else
                        cell.detailTextLabel.text = @"No record";
                    break;
            }
            break;
    }
    
    return cell;
}

@end
