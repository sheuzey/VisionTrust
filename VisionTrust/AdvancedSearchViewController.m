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
@property (nonatomic, strong) NSMutableDictionary *parameters;
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
    
    self.parameters = [[NSMutableDictionary alloc] init];
    
    self.searchTable.dataSource = self;
    self.searchTable.delegate = self;
    
    self.actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
    [self.actionSheet setActionSheetStyle:UIActionSheetStyleBlackOpaque];
    
    self.pickerToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
    [self.pickerToolBar setBarStyle:UIBarStyleBlack];
}

- (IBAction)searchButtonPressed:(id)sender {
    NSMutableArray *array = [self.database getChildrenWithParameters:self.parameters];
    [self.delegate exitAdvancedSearchWithChildren:array];
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
            [self.parameters setValue:title forKey:@"country"];
            break;
        case PROJECT_TAG:
            [self.parameters setValue:title forKey:@"isPartOfProject.name"];
            break;
        case GENDER_TAG:
            [self.parameters setValue:title forKey:@"gender"];
            break;
        case STATUS_TAG:
            [self.parameters setValue:title forKey:@"status"];
            break;
    }
    //Reset selected index, reload table and dismiss actionSheet
    self.selectedIndex = 0;
    [self.searchTable reloadData];
    [self.actionSheet dismissWithClickedButtonIndex:0 animated:YES];
}

- (void)countryButtonPressed {
    
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
    
    //Add buttons to toolbar and add to actionSheet..
    [self addToolBarWithButtonsAndTitle:@"Country" andTag:COUNTRY_TAG];
    [self.actionSheet addSubview:self.pickerToolBar];
    
    [self.actionSheet showInView:self.view];
    [self.actionSheet setBounds:CGRectMake(self.view.bounds.origin.x,
                                           self.view.bounds.origin.y,
                                           self.view.bounds.size.width,
                                           self.view.bounds.size.height + 30)];
}

- (void)projectButtonPressed {
    
    [self createPicker];
    
    //Set data for picker, sort and add to subviews..
    NSArray *children = [self.database getAllChildren];
    self.dataArray = [[NSMutableArray alloc] initWithObjects:@"All", nil];
    for (Child *child in children) {
        if (![self.dataArray containsObject:child.isPartOfProject.name]) {
            [self.dataArray addObject:child.isPartOfProject.name];
        }
    }
    [self.dataArray sortUsingSelector:@selector(compare:)];
    [self.actionSheet addSubview:self.pickerView];
    
    //Add buttons to toolbar and add to actionSheet..
    [self addToolBarWithButtonsAndTitle:@"Project" andTag:PROJECT_TAG];
    [self.actionSheet addSubview:self.pickerToolBar];
    
    [self.actionSheet showInView:self.view];
    [self.actionSheet setBounds:CGRectMake(self.view.bounds.origin.x,
                                           self.view.bounds.origin.y,
                                           self.view.bounds.size.width,
                                           self.view.bounds.size.height + 30)];
}

- (void)genderButtonPressed {
    
    [self createPicker];
    
    self.dataArray = [[NSMutableArray alloc] initWithObjects:@"All", @"Female", @"Male", nil];
    [self.actionSheet addSubview:self.pickerView];
    
    //Add buttons to toolbar and add to actionSheet..
    [self addToolBarWithButtonsAndTitle:@"Gender" andTag:GENDER_TAG];
    [self.actionSheet addSubview:self.pickerToolBar];
    
    [self.actionSheet showInView:self.view];
    [self.actionSheet setBounds:CGRectMake(self.view.bounds.origin.x,
                                           self.view.bounds.origin.y,
                                           self.view.bounds.size.width,
                                           self.view.bounds.size.height + 30)];
}

- (void)statusButtonPressed {
    
    [self createPicker];
    self.dataArray = [[NSMutableArray alloc] initWithObjects:@"All", @"Active", @"Inactive", nil];
    [self.actionSheet addSubview:self.pickerView];
    
    //Add buttons to toolbar and add to actionSheet..
    [self addToolBarWithButtonsAndTitle:@"Status" andTag:STATUS_TAG];
    [self.actionSheet addSubview:self.pickerToolBar];
    
    [self.actionSheet showInView:self.view];
    [self.actionSheet setBounds:CGRectMake(self.view.bounds.origin.x,
                                           self.view.bounds.origin.y,
                                           self.view.bounds.size.width,
                                           self.view.bounds.size.height + 30)];
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
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    switch ([indexPath section]) {
        case 0:
            cell.textLabel.text = [self.parameters valueForKey:@"country"] ? [self.parameters valueForKey:@"country"] : @"All";
            break;
        case 1:
            cell.textLabel.text = [self.parameters valueForKey:@"isPartOfProject.name"] ? [self.parameters valueForKey:@"isPartOfProject.name"] : @"All";
            break;
        case 2:
            cell.textLabel.text = [self.parameters valueForKey:@"gender"] ? [self.parameters valueForKey:@"gender"] : @"All";
            break;
        case 3:
            cell.textLabel.text = [self.parameters valueForKey:@"status"] ? [self.parameters valueForKey:@"status"] : @"All";
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.searchTable deselectRowAtIndexPath:indexPath animated:YES];
    switch ([indexPath section]) {
        case 0:
            [self countryButtonPressed];
            break;
        case 1:
            [self projectButtonPressed];
            break;
        case 2:
            [self genderButtonPressed];
            break;
        case 3:
            [self statusButtonPressed];
            break;
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"Country";
            break;
        case 1:
            return @"Project";
            break;
        case 2:
            return @"Gender";
            break;
        case 3:
            return @"Status";
            break;
        default:
            return @"";
            break;
    }
}

@end
