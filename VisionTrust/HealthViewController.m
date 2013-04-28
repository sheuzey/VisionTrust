//
//  HealthViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/27/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "HealthViewController.h"

@interface HealthViewController ()
@end

@implementation HealthViewController

#define HEALTH @"healthCondition"
#define TREATMENT @"currentlyReceivingTreatment"
#define ILLNESS @"chronicIllness"
#define HEALTH_COMMENTS @"healthComments"

- (void)viewDidLoad
{
    [super viewDidLoad];
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
                    if (self.interaction.healthCondition)
                        cell.detailTextLabel.text = self.interaction.healthCondition;
                    else
                        cell.detailTextLabel.text = @"No record";
                    break;
                case 1:
                    cell.textLabel.text = @"Medical Treatment";
                    if (self.interaction.currentlyReceivingTreatment == [NSNumber numberWithInt:0])
                        cell.detailTextLabel.text = @"No";
                    else if (self.interaction.currentlyReceivingTreatment == [NSNumber numberWithInt:1])
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
                    if (self.interaction.chronicIllness)
                        cell.detailTextLabel.text = self.interaction.chronicIllness;
                    else
                        cell.detailTextLabel.text = @"No record";
                    break;
                case 1:
                    cell.textLabel.text = @"Other Comments";
                    if (self.interaction.healthComments)
                        cell.detailTextLabel.text = self.interaction.healthComments;
                    else
                        cell.detailTextLabel.text = @"No record";
                    break;
            }
            break;
    }
    
    return cell;
}

//Only for exiting to ViewUpdate controller..
- (IBAction)doneButtonPressed:(id)sender {
    [self.delegate exitCategory];
}

@end
