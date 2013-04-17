//
//  AdvancedSearchViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/16/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "AdvancedSearchViewController.h"

@interface AdvancedSearchViewController ()

@end

@implementation AdvancedSearchViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + 480, self.view.frame.size.width, self.view.frame.size.height)];
    self.pickerView.showsSelectionIndicator = YES;
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    self.pickerView.alpha = 0.0;
    [self.view addSubview:self.pickerView];
}

- (IBAction)searchButtonPressed:(id)sender {
    [self.delegate exitAdvancedSearch];
}

- (IBAction)countryButtonPressed:(id)sender {
    [UIView animateWithDuration:.25
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseInOut
                     animations:^(void) {
                         [self.pickerView setFrame:CGRectMake(0, 250, 320, 216)];
                         self.pickerView.alpha = self.pickerView.alpha * (-1) + 1;
                     } completion:NULL];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //do stuff..
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 5;
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [NSString stringWithFormat:@"%d", row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 300;
}

@end
