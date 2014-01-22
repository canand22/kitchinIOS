//
//  KIAAddItemViewController.m
//  KitchInApp
//
//  Created by DeMoN on 1/15/14.
//  Copyright (c) 2014 NIX. All rights reserved.
//

#import "KIAAddItemViewController.h"

#import "KIAServerGateway.h"

@interface KIAAddItemViewController ()

@end

@implementation KIAAddItemViewController

@synthesize getItemGateway = _getItemGateway;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        // Custom initialization
        _storeArray = @[@"Potash store", @"Other"];
        
        _getItemGateway = [KIAServerGateway gateway];
    }
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    [_getItemGateway getItemWithCategoyId:1 storeId:1 delegate:self];
}

#pragma mark ***** picker view *****

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_storeArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_storeArray objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [_selectStoreTextFild setText:[_storeArray objectAtIndex:row]];
    [_picker setHidden:![_picker isHidden]];
    
    if ([[_storeArray objectAtIndex:row] isEqualToString:@"Other"])
    {
        [_addNewItem setHidden:NO];
        [_addKitchInItem setHidden:YES];
    }
    else
    {
        [_addKitchInItem setHidden:NO];
        [_addNewItem setHidden:YES];
    }
}

#pragma mark *****

- (IBAction)checkStore:(id)sender
{
    [_picker setHidden:![_picker isHidden]];
}

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
