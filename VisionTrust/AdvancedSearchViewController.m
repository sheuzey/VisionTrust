//
//  AdvancedSearchViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/15/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "AdvancedSearchViewController.h"
#import "Child.h"

@interface AdvancedSearchViewController ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) NSInteger selectedIndex;
@end

@implementation AdvancedSearchViewController

#define COUNTRY_TAG 200
#define PROJECT_TAG 300
#define GENDER_TAG 400
#define STATUS_TAG 500

- (void)createPicker
{
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 40, 0, 0)];
    self.pickerView.showsSelectionIndicator = YES;
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    [self.actionSheet setActionSheetStyle:UIActionSheetStyleBlackOpaque];
    
    self.pickerToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
    [self.pickerToolBar setBarStyle:UIBarStyleBlack];
    
    [self createPicker];
}

- (IBAction)searchButtonPressed:(id)sender {
    [self.delegate exitAdvancedSearch];
}

- (void)addToolBarWithButtonsAndTitle:(NSString *)title andTag:(NSInteger)tag
{
    //Cancel Button..
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed)];
    
    //Title Label..
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 180, 30)];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:16]];
    [titleLabel setBackgroundColor:[UIColor clearColor]];
    [titleLabel setText:title];
    UIBarButtonItem *titleButton = [[UIBarButtonItem alloc] initWithCustomView:titleLabel];
    titleButton.title = title;
    
    //Done Button..
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed)];
    doneButton.tag = tag;
    
    //Add to array, then add to toolbar..
    [barItems addObject:cancelButton];
    [barItems addObject:titleButton];
    [barItems addObject:doneButton];
    [self.pickerToolBar setItems:barItems animated:YES];
}

- (void)cancelButtonPressed
{
    [self.actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)doneButtonPressed
{
    UIBarButtonItem *item = [self.pickerToolBar.items lastObject];
    NSString *title = [self.dataArray objectAtIndex:self.selectedIndex];
    switch (item.tag) {
        case COUNTRY_TAG:
            [self.countryButton setTitle:title forState:UIControlStateNormal];
            break;
        case GENDER_TAG:
            [self.genderButton setTitle:title forState:UIControlStateNormal];
            break;
        case STATUS_TAG:
            [self.statusButton setTitle:title forState:UIControlStateNormal];
            break;
    }
    //Reset selected index, and dismiss actionSheet
    self.selectedIndex = 0;
    [self.actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

- (IBAction)countryButtonPressed:(id)sender {
    
    [self createPicker];
    
    //Set data for picker, sort and add to subviews..
    NSArray *children = [self.database getAllChildren];
    self.dataArray = [[NSMutableArray alloc] initWithObjects:@"All", nil];
    for (Child *child in children) {
        if (![self.dataArray containsObject:child.country]) {
            [self.dataArray addObject:child.country];
        }
    }
    [self.dataArray sortUsingSelector:@selector(compare:)];
    [self.actionSheet addSubview:self.pickerView];
    
    //Add buttons to toolbar, reload components and add toolbar to actionSheet..
    [self addToolBarWithButtonsAndTitle:@"Country" andTag:COUNTRY_TAG];
    [self.actionSheet addSubview:self.pickerToolBar];
    
    [self.actionSheet showInView:self.view];
    [self.actionSheet setBounds:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height + 30)];
}

- (IBAction)projectButtonPressed:(id)sender {
    
    [self createPicker];
    
    //Set data for picker, sort and add to subviews..
    
}

- (IBAction)genderButtonPressed:(id)sender {
    
    [self createPicker];
    
    self.dataArray = [[NSMutableArray alloc] initWithObjects:@"All", @"Female", @"Male", nil];
    [self.actionSheet addSubview:self.pickerView];
    
    //Add buttons to toolbar, reload components and add toolbar to actionSheet..
    [self addToolBarWithButtonsAndTitle:@"Gender" andTag:GENDER_TAG];
    [self.actionSheet addSubview:self.pickerToolBar];
    
    [self.actionSheet showInView:self.view];
    [self.actionSheet setBounds:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height + 30)];
}

- (IBAction)statusButtonPressed:(id)sender {
    
    [self createPicker];
    self.dataArray = [[NSMutableArray alloc] initWithObjects:@"All", @"Active", @"Inactive", nil];
    [self.actionSheet addSubview:self.pickerView];
    
    //Add buttons to toolbar, reload components and add toolbar to actionSheet..
    [self addToolBarWithButtonsAndTitle:@"Status" andTag:STATUS_TAG];
    [self.actionSheet addSubview:self.pickerToolBar];
    
    [self.actionSheet showInView:self.view];
    [self.actionSheet setBounds:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width, self.view.bounds.size.height + 30)];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.selectedIndex = row;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [self.dataArray count];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.dataArray objectAtIndex:row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return 300;
}

@end
