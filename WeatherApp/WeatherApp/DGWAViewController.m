//
//  DGWAViewController.m
//  WeatherApp
//
//  Created by David Gianforte on 3/29/13.
//  Copyright (c) 2013 David Gianforte. All rights reserved.
//

#import "DGWAViewController.h"

@interface DGWAViewController ()

@end

@implementation DGWAViewController
{
    IBOutlet UILabel *temp;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [temp setText:[[NSString alloc] initWithFormat:@"%3.0f °F", [masterWeatherData KtoF:[masterWeatherData getAvgTemp]]]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
