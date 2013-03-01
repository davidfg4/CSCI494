//
//  DG5DataPickerViewController.m
//  iOS assignment 5
//
//  Created by David Gianforte on 2/28/13.
//  Copyright (c) 2013 David Gianforte. All rights reserved.
//

#import "DG5DataPickerViewController.h"

@interface DG5DataPickerViewController () <UIPickerViewDataSource, UIPickerViewDelegate>
{
        __weak IBOutlet UIPickerView *picker;
}

-(IBAction) tappedPicker;

@end

@implementation DG5DataPickerViewController

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
    [picker selectRow:[masterWeatherData getDataInt] inComponent:0 animated:NO];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) tappedPicker
{
    NSLog( @"picked row %d", [picker selectedRowInComponent:0] );
    [masterWeatherData updateDataSource:[picker selectedRowInComponent:0]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSInteger) numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [collections count];
}

-(NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return collections[row][@"variable"];
}

@end
