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
    IBOutlet UILabel *tempF;
    IBOutlet UILabel *tempC;
    IBOutlet UIImageView *weatherIcon;
    IBOutlet UILabel *date;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [tempF setText:[[NSString alloc] initWithFormat:@"%3.0f °F", [masterWeatherData KtoF:[masterWeatherData getAvgTemp]]]];
    [tempC setText:[[NSString alloc] initWithFormat:@"%3.1f °C", [masterWeatherData KtoC:[masterWeatherData getAvgTemp]]]];
    weatherIcon.image = [UIImage imageNamed:[masterWeatherData getIconName]];
    [date setText:[masterWeatherData getWeatherName]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
