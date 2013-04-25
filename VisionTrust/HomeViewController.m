//
//  HomeViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/13/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "HomeViewController.h"
#import "SearchTableViewController.h"
#import "RegisterChildViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "Cell.h"

@interface HomeViewController ()
@property BOOL goToUpdate;
@end

@implementation HomeViewController

- (IBAction)logoutButtonPressed:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //Set background color..
    self.view.backgroundColor = [UIColor clearColor];
    UITableView *tv = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    [self.view addSubview:tv];
    [self.view sendSubviewToBack:tv];
    
    //Set welcome label..
    self.welcomeLabel.text = self.firstName;
    self.title = @"Main Menu";
    
    //Change background color of collection view..
    self.menuCollection.backgroundColor = [UIColor clearColor];
    
    self.navigationController.navigationBarHidden = NO;
    self.navigationItem.hidesBackButton = YES;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 4;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    Cell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.image.layer.masksToBounds = YES;
    cell.image.layer.cornerRadius = 10.0;
    cell.image.layer.borderWidth = 2.0;
    cell.image.layer.borderColor = [[UIColor blackColor] CGColor];
    
    switch ([indexPath row]) {
        case 0:
            cell.label.text = @"View Child Profile";
            cell.image.image = [UIImage imageNamed:@"profile.jpeg"];
            break;
        case 1:
            cell.label.text = @"Register New Child";
            cell.image.image = [UIImage imageNamed:@"signup.jpeg"];
            break;
        case 2:
            cell.label.text = @"Update Child Profile";
            cell.image.image = [UIImage imageNamed:@"update.jpeg"];
            break;
        case 3:
            cell.label.text = @"Child Departure";
            cell.image.image = [UIImage imageNamed:@"departure.jpeg"];
            break;
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath row] == 0) {
        self.goToUpdate = NO;
        [self performSegueWithIdentifier:@"Search" sender:self];
    } else if([indexPath row] == 1) {
        [self performSegueWithIdentifier:@"Register" sender:self];
    } else if ([indexPath row] == 2) {
        self.goToUpdate = YES;
        [self performSegueWithIdentifier:@"Search" sender:self];
    } else if ([indexPath row] == 3) {
        [self performSegueWithIdentifier:@"SearchThenEnrollment" sender:self];
    }
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Search"]) {
        SearchTableViewController *stvc = (SearchTableViewController *)segue.destinationViewController;
        stvc.goToUpdate = self.goToUpdate;
    }
}

@end
