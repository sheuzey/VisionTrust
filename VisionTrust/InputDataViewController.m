//
//  InputDataViewController.m
//  VisionTrust
//
//  Created by Stephen Heuzey on 4/20/13.
//  Copyright (c) 2013 Stephen Heuzey. All rights reserved.
//

#import "InputDataViewController.h"

@interface InputDataViewController ()
@end

@implementation InputDataViewController

#define DATA_TAG 100

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return self.titleString;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    UITextField *inputField;
    if(cell == nil)
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    inputField = [[UITextField alloc] initWithFrame:CGRectMake(20,
                                                               10,
                                                               cell.bounds.size.width,
                                                               cell.bounds.size.height)];
    inputField.adjustsFontSizeToFitWidth = YES;
    inputField.delegate = self;
    
    inputField.placeholder = self.titleString;
    inputField.text = self.dataString;
    inputField.tag = DATA_TAG;
    
    [cell addSubview:inputField];
    return cell;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (void)viewWillDisappear:(BOOL)animated
{
    UITextField *data = (UITextField *)[[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]] viewWithTag:DATA_TAG];
    NSString *text = [data.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    [self.delegate giveBackData:text];
}

@end
