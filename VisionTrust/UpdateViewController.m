//
//  UpdateViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/25/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "UpdateViewController.h"
#import "UpdateAcademicViewController.h"
#import "RegisterHealthViewController.h"
#import "UpdateSpiritualViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface UpdateViewController () <UpdateAcademicProtocol, HealthRegistrationProtocol, UpdateSpiritualProtocol>
@property (nonatomic, assign) NSInteger selectedGuardianIndex;
@property (nonatomic, strong) NSMutableDictionary *academicData;
@property (nonatomic, strong) NSMutableDictionary *healthData;
@property (nonatomic, strong) NSMutableDictionary *spiritualData;
@property (nonatomic, strong) NSMutableDictionary *homeData;
@end

@implementation UpdateViewController 

#define FAVORITE_SUBJECTS @"favoriteSubjects"
#define SPIRITUAL_ACTIVITIES @"activities"

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Set background color..
    self.view.backgroundColor = [UIColor clearColor];
    UITableView *tv = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:tv];
    [self.view sendSubviewToBack:tv];
    
    //Setup title and picture..
    self.title = [NSString stringWithFormat:@"%@ %@", self.interaction.child.firstName, self.interaction.child.lastName];
    
    //If image data exists, use data. Else use url..
    if (self.interaction.child.pictureData)
        [self.childImageView setImage:[[UIImage alloc] initWithData:self.interaction.child.pictureData]];
    else
        [self.childImageView setImage:[UIImage imageNamed:self.interaction.child.pictureURL]];
    
    self.childImageView.layer.masksToBounds = YES;
    self.childImageView.layer.cornerRadius = 5.0;
    self.tableView.backgroundView = nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    //Configure...
    switch ([indexPath section]) {
        case 0:
            cell.textLabel.text = @"Academic";
            break;
        case 1:
            cell.textLabel.text = @"Health";
            break;
        case 2:
            cell.textLabel.text = @"Spiritual";
            break;
        case 3:
            cell.textLabel.text = @"Home Life";
            break;
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([indexPath section]) {
        case 0:
            [self performSegueWithIdentifier:@"GoToAcademic" sender:self];
            break;
        case 1:
            [self performSegueWithIdentifier:@"GoToHealth" sender:self];
            break;
        case 2:
            [self performSegueWithIdentifier:@"GoToSpiritual" sender:self];
            break;
        case 3:
            [self performSegueWithIdentifier:@"GoToHomeLife" sender:self];
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"GoToAcademic"]) {
        UpdateAcademicViewController *uavc = (UpdateAcademicViewController *)segue.destinationViewController;
        uavc.academicData = [[NSMutableDictionary alloc] initWithDictionary:self.academicData];
        uavc.favoriteSubjects = [[NSMutableArray alloc] initWithArray:[self.academicData valueForKey:FAVORITE_SUBJECTS]];
        uavc.delegate = self;
    } else if ([segue.identifier isEqualToString:@"GoToHealth"]) {
        RegisterHealthViewController *rhvc = (RegisterHealthViewController *)segue.destinationViewController;
        rhvc.healthData = [[NSMutableDictionary alloc] initWithDictionary:self.healthData];
        rhvc.delegate = self;
    } else if ([segue.identifier isEqualToString:@"GoToSpiritual"]) {
        UpdateSpiritualViewController *usvc = (UpdateSpiritualViewController *)segue.destinationViewController;
        usvc.spiritualData = [[NSMutableDictionary alloc] initWithDictionary:self.spiritualData];
        usvc.spiritualActivities = [[NSMutableArray alloc] initWithArray:[self.spiritualData valueForKey:SPIRITUAL_ACTIVITIES]];
        usvc.delegate = self;
    } else if ([segue.identifier isEqualToString:@"GoToHomeLife"]) {
        
    }
}

- (void)academicInfo:(NSMutableDictionary *)info
{
    self.academicData = [[NSMutableDictionary alloc] initWithDictionary:info];
}

- (void)healthInfo:(NSMutableDictionary *)info
{
    self.healthData = [[NSMutableDictionary alloc] initWithDictionary:info];
}

- (void)spiritualInfo:(NSMutableDictionary *)info
{
    self.spiritualData = [[NSMutableDictionary alloc] initWithDictionary:info];
}

@end
