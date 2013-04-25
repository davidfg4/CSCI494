//
//  DGWANowViewController.m
//  WeatherApp
//
//  Created by David Gianforte on 4/25/13.
//  Copyright (c) 2013 David Gianforte. All rights reserved.
//

#import "DGWANowViewController.h"

@interface DGWANowViewController ()

@end

@implementation DGWANowViewController

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
    [masterWeatherData setWeatherTime:1];
    // set to one so that when tomorrow loads, it will be correct
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
