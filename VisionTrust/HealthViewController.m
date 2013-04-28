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
    switch ([indexPath section]) {
        case 0:
            switch ([indexPath row]) {
                case 0:
                    cell.textLabel.text = @"Health";
                    cell.detailTextLabel.text = self.latestInteraction.healthCondition;
                    break;
                case 1:
                    cell.textLabel.text = @"Medical Treatment";
                    if (self.latestInteraction.currentlyReceivingTreatment == [NSNumber numberWithInt:0])
                        cell.detailTextLabel.text = @"No";
                    else if (self.latestInteraction.currentlyReceivingTreatment == [NSNumber numberWithInt:1])
                        cell.detailTextLabel.text = @"Yes";
                    else
                        cell.detailTextLabel.text = nil;
                    break;
            }
            break;
        case 1:
            switch ([indexPath row]) {
                case 0:
                    cell.textLabel.text = @"Illness";
                    cell.detailTextLabel.text = self.latestInteraction.chronicIllness;
                    break;
                case 1:
                    cell.textLabel.text = @"Other Comments";
                    cell.detailTextLabel.text = self.latestInteraction.healthComments;
                    break;
            }
            break;
    }
    
    return cell;
}

@end
