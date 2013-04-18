//
//  AdvancedSearchViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/15/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "AdvancedSearchViewController.h"

@interface AdvancedSearchViewController ()

@end

@implementation AdvancedSearchViewController

#define PICKER_VIEW_TAG 100
#define CANCEL_BUTTON_TAG 110
#define DONE_BUTTON_TAG 120

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    [self.actionSheet setActionSheetStyle:UIActionSheetStyleBlackOpaque];
    
    self.pickerToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 40)];
    [self.pickerToolBar setBarStyle:UIBarStyleBlack];
    
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, 0, 0)];
    self.pickerView.showsSelectionIndicator = YES;
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    self.pickerView.tag = PICKER_VIEW_TAG;
}

- (IBAction)searchButtonPressed:(id)sender {
    [self.delegate exitAdvancedSearch];
}

- (void)cancelButtonPressed
{
    [self.actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)doneButtonPressed
{
    
}

- (IBAction)countryButtonPressed:(id)sender {
    
    //Remove previous picker from action sheet, then add new picker..
    for (UIView *view in self.actionSheet.subviews) {
        if (view.tag == PICKER_VIEW_TAG) {
            [view removeFromSuperview];
        }
    }
    [self.actionSheet addSubview:self.pickerView];

    //Cancel Button..
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed)];
    cancelButton.tag = CANCEL_BUTTON_TAG;
    
    //Title Label..
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 30)];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setText:@"Country"];
    UIBarButtonItem *titleButton = [[UIBarButtonItem alloc] initWithCustomView:titleLabel];
    
    //Done Button..
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed)];
    doneButton.tag = DONE_BUTTON_TAG;
    
    //Add to array, then add to toolbar..
    [barItems addObject:cancelButton];
    [barItems addObject:titleButton];
    [barItems addObject:doneButton];
    [self.pickerToolBar setItems:barItems animated:YES];
    
    [self.actionSheet addSubview:self.pickerToolBar];
    [self.actionSheet showInView:self.view];
    [self.actionSheet setBounds:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height + 30)];
}

- (void)dismissActionSheet:(UIActionSheet *)sheet withControlEvent:(UIEvent *)event
{
    
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
