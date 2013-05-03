//
//  DGWAViewController.m
//  WeatherApp
//
//  Created by David Gianforte on 3/29/13.
//  Copyright (c) 2013 David Gianforte. All rights reserved.
//

// Great job. With a little more UI polish, this could be a successful app.
// Project grade: 100%
// Course grade: 100%

#import "DGWAViewController.h"

@interface DGWAViewController ()

@end

@implementation DGWAViewController
{
    IBOutlet UILabel *tempF;
    IBOutlet UILabel *tempC;
    IBOutlet UIImageView *weatherIcon;
    IBOutlet UILabel *rainLabel;
    IBOutlet UILabel *snowLabel;
    
    IBOutlet UILabel *date;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [tempF setText:[[NSString alloc] initWithFormat:@"%3.0f °F", [masterWeatherData KtoF:[masterWeatherData getAvgTemp]]]];
    [tempC setText:[[NSString alloc] initWithFormat:@"%3.1f °C", [masterWeatherData KtoC:[masterWeatherData getAvgTemp]]]];
    weatherIcon.image = [UIImage imageNamed:[masterWeatherData getIconName]];
    [rainLabel setText:[[NSString alloc] initWithFormat:@"Rain: %2.0f%%", [masterWeatherData getRainChance]*100]];
    [snowLabel setText:[[NSString alloc] initWithFormat:@"Snow: %2.0f%%", [masterWeatherData getSnowChance]*100]];
    
    [date setText:[masterWeatherData getWeatherName]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
