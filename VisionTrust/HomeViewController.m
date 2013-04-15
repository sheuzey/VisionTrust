//
//  HomeViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/13/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "HomeViewController.h"
#import "Cell.h"
#import "SearchTableViewController.h"

@interface HomeViewController ()
@end

@implementation HomeViewController

- (IBAction)logoutButtonPressed:(id)sender {

    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
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
    if ([indexPath row] == 0 || [indexPath row] == 2 || [indexPath row] == 3) {
        [self performSegueWithIdentifier:@"GoToSearch" sender:self];
    } else if([indexPath row] == 1) {
        [self performSegueWithIdentifier:@"GoToPersonal" sender:self];
    }
    [self.menuCollection deselectItemAtIndexPath:indexPath animated:YES];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"GoToSearch"]) {
        SearchTableViewController *stvc = (SearchTableViewController *)segue.destinationViewController;
        stvc.children = self.children;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
