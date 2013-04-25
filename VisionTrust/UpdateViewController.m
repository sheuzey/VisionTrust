//
//  UpdateViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/25/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "UpdateViewController.h"
#import "UpdateAcademicViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface UpdateViewController () <UpdateAcademicProtocol>
@property (nonatomic, assign) NSInteger selectedGuardianIndex;
@end

@implementation UpdateViewController 

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.database = [VisionTrustDatabase vtDatabase];
    self.child = self.interaction.child;
    self.academicData = [[NSMutableDictionary alloc] initWithDictionary:[self.database getAcademicDataFromInteraction:self.interaction]];
    
    //Set background color..
    self.view.backgroundColor = [UIColor clearColor];
    UITableView *tv = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:tv];
    [self.view sendSubviewToBack:tv];
    
    //Setup title and picture..
    self.title = [NSString stringWithFormat:@"%@ %@", self.child.firstName, self.child.lastName];
    
    //If image data exists, use data. Else use url..
    if (self.child.pictureData)
        [self.childImageView setImage:[[UIImage alloc] initWithData:self.child.pictureData]];
    else
        [self.childImageView setImage:[UIImage imageNamed:self.child.pictureURL]];
    
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
    } else if ([segue.identifier isEqualToString:@"GoToHealth"]) {
        
    } else if ([segue.identifier isEqualToString:@"GoToSpiritual"]) {
        
    } else if ([segue.identifier isEqualToString:@"GoToHomeLife"]) {
        
    } else if ([segue.identifier isEqualToString:@"GoToGuardian"]) {
        
    }
}

- (void)academicInfo:(NSMutableDictionary *)info
{
    self.academicData = [[NSMutableDictionary alloc] initWithDictionary:info];
}

@end
