//
//  DepartureViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/29/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "DepartureViewController.h"
#import "InputDataViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface DepartureViewController () <GetData>
@property (nonatomic, strong) NSMutableDictionary *departureInfo;
@property (nonatomic, strong) NSString *selectedCellText;
@property (nonatomic, strong) NSString *dataString;
@property (nonatomic, strong) VisionTrustDatabase *database;
@end

@implementation DepartureViewController

#define DEPARTURE_REASON @"departureReason"
#define DEPARTURE_COMMENTS @"departureComments"

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.database = [VisionTrustDatabase vtDatabase];
    self.tableView.backgroundView = nil;
    
    //Set background color..
    self.view.backgroundColor = [UIColor clearColor];
    UITableView *tv = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:tv];
    [self.view sendSubviewToBack:tv];
    
    //Setup imageView..
    //If image data exists, use data. Else use url..
    if (self.child.pictureData)
        [self.childImageView setImage:[[UIImage alloc] initWithData:self.child.pictureData]];
    else
        [self.childImageView setImage:[UIImage imageNamed:self.child.pictureURL]];
    
    self.childImageView.layer.masksToBounds = YES;
    self.childImageView.layer.cornerRadius = 5.0;
    
    //Setup departureInfo..
    self.departureInfo = [[NSMutableDictionary alloc] init];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Departure Reason";
            break;
        default:
            return @"Comments";
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    //Configure Cell..
    switch ([indexPath section]) {
        case 0:
            cell.textLabel.text = [self.departureInfo valueForKey:DEPARTURE_REASON];
            break;
        case 1:
            cell.textLabel.text = [self.departureInfo valueForKey:DEPARTURE_COMMENTS];
            break;
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch ([indexPath section]) {
        case 0:
            self.selectedCellText = @"Departure Reason";
            self.dataString = [self.departureInfo valueForKey:DEPARTURE_REASON];
            break;
        case 1:
            self.selectedCellText = @"Comments";
            self.dataString = [self.departureInfo valueForKey:DEPARTURE_COMMENTS];
            break;
    }
    [self performSegueWithIdentifier:@"InputData" sender:self];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"InputData"]) {
        InputDataViewController *idvc = (InputDataViewController *)segue.destinationViewController;
        idvc.titleString = self.selectedCellText;
        idvc.dataString = self.dataString;
        idvc.delegate = self;
    }
}

- (void)giveBackData:(NSString *)data
{
    if ([self.selectedCellText isEqualToString:@"Departure Reason"])
        [self.departureInfo setValue:data forKey:DEPARTURE_REASON];
    else if ([self.selectedCellText isEqualToString:@"Comments"])
        [self.departureInfo setValue:data forKey:DEPARTURE_COMMENTS];
    
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancelButtonPressed:(id)sender {
    [self.delegate exitDeparture];
}

- (IBAction)submitButtonPressed:(id)sender {
    
    // Store register button to display after activity indicator
    UIBarButtonItem *registerButton = self.navBar.rightBarButtonItem;
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc]
                                        initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    self.navBar.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    
    //Asynchronously register child..
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self.database departChild:self.child
                 withDepartureData:self.departureInfo];
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                        message:@"Child successfully departed"
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
        [alert show];
        self.navBar.rightBarButtonItem = registerButton;
    });
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.delegate exitDeparture];
}

@end
