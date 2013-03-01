//
//  DG5DatePickerViewController.m
//  iOS assignment 5
//
//  Created by David Gianforte on 3/1/13.
//  Copyright (c) 2013 David Gianforte. All rights reserved.
//

#import "DG5DatePickerViewController.h"

@interface DG5DatePickerViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
{
    __weak IBOutlet UIPickerView *picker;
}

-(IBAction) tappedPicker;

@end

@implementation DG5DatePickerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [picker selectRow:[masterWeatherData getDateInt] inComponent:0 animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) tappedPicker
{
    NSLog( @"picked row %d", [picker selectedRowInComponent:0] );
    [masterWeatherData updateDate:[picker selectedRowInComponent:0]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [collections[0][@"values"] count];
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return collections[0][@"values"][row][@"date"];
}


@end
