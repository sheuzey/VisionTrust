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
#import "UpdateHomeLifeViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <QuartzCore/QuartzCore.h>

@interface UpdateViewController () <UpdateAcademicProtocol, HealthRegistrationProtocol, UpdateSpiritualProtocol, UpdateHomeProtocol, UIAlertViewDelegate, UIImagePickerControllerDelegate, UINavigationBarDelegate>
@property (nonatomic, assign) NSInteger selectedGuardianIndex;
@property (nonatomic, strong) UIPopoverController *imagePopover;
@property (nonatomic, strong) NSMutableDictionary *academicData;
@property (nonatomic, strong) NSMutableDictionary *healthData;
@property (nonatomic, strong) NSMutableDictionary *spiritualData;
@property (nonatomic, strong) NSMutableDictionary *homeData;
@end

@implementation UpdateViewController 

#define FAVORITE_SUBJECTS @"favoriteSubjects"
#define SPIRITUAL_ACTIVITIES @"spiritualActivities"

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.database = [VisionTrustDatabase vtDatabase];
    
    //Set background color..
    self.view.backgroundColor = [UIColor clearColor];
    UITableView *tv = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:tv];
    [self.view sendSubviewToBack:tv];
    
    //Add gesture recognizer to imageView..
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageWasTapped:)];
    [self.childImageView addGestureRecognizer:tapRecognizer];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(8, 40, 375, 20)];
    [label setBackgroundColor:[UIColor clearColor]];
    label.text = @"Take picture";
    label.tag = 100;
    [self.childImageView addSubview:label];
    self.childImageView.layer.masksToBounds = YES;
    self.childImageView.layer.cornerRadius = 5.0;
    self.childImageView.layer.borderWidth = 2.5;
    
    //Setup title and picture..
    self.title = [NSString stringWithFormat:@"%@ %@", self.child.firstName, self.child.lastName];
    
    self.tableView.backgroundView = nil;
}

#define IMAGE_PICKER_IN_POPOVER YES

- (void)imageWasTapped:(UITapGestureRecognizer *)tapGesture
{
    if(!self.imagePopover && [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
        if([mediaTypes containsObject:(NSString *)kUTTypeImage]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            picker.mediaTypes = [NSArray arrayWithObject:(NSString *)kUTTypeImage];
            picker.allowsEditing = YES;
            if(IMAGE_PICKER_IN_POPOVER && (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)) {
                self.imagePopover = [[UIPopoverController alloc] initWithContentViewController:picker];
                [self.imagePopover presentPopoverFromRect:self.view.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            } else {
                [self presentViewController:picker animated:YES completion:nil];
            }
        }
    }
}

- (void)dismissImagePicker
{
    [self.imagePopover dismissPopoverAnimated:YES];
    self.imagePopover = nil;
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if(!image) image = [info objectForKey:UIImagePickerControllerOriginalImage];
    if(image) {
        [self.childImageView setContentMode:UIViewContentModeScaleAspectFit];
        [self.childImageView setImage:image];
    }
    self.child.pictureData = UIImagePNGRepresentation(self.childImageView.image);
    
    //Remove label..
    for (UIView *view in self.childImageView.subviews) {
        if (view.tag == 100)
            [view removeFromSuperview];
    }
    [self dismissImagePicker];
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
        uavc.delegate = self;
    } else if ([segue.identifier isEqualToString:@"GoToHealth"]) {
        RegisterHealthViewController *rhvc = (RegisterHealthViewController *)segue.destinationViewController;
        rhvc.healthData = [[NSMutableDictionary alloc] initWithDictionary:self.healthData];
        rhvc.delegate = self;
    } else if ([segue.identifier isEqualToString:@"GoToSpiritual"]) {
        UpdateSpiritualViewController *usvc = (UpdateSpiritualViewController *)segue.destinationViewController;
        usvc.spiritualData = [[NSMutableDictionary alloc] initWithDictionary:self.spiritualData];
        usvc.delegate = self;
    } else if ([segue.identifier isEqualToString:@"GoToHomeLife"]) {
        UpdateHomeLifeViewController *uhlvc = (UpdateHomeLifeViewController *)segue.destinationViewController;
        uhlvc.homeData = [[NSMutableDictionary alloc] initWithDictionary:self.homeData];
        uhlvc.delegate = self;
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

- (void)homeInfo:(NSMutableDictionary *)info
{
    self.homeData = [[NSMutableDictionary alloc] initWithDictionary:info];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)updateButtonPressed:(id)sender {
    
    // Store register button to display after activity indicator
    UIBarButtonItem *registerButton = self.navigationItem.rightBarButtonItem;
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc]
                                        initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    
    //Asynchronously update child..
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        //Call update method..
        [self.database updateChild:self.child
                  WithAcademicData:self.academicData
                        healthData:self.healthData
                     spiritualData:self.spiritualData
                       andHomeData:self.homeData];
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success"
                                                        message:@"Update complete"
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
        [alert show];
        self.navigationItem.rightBarButtonItem = registerButton;
    });
}

@end
