//
//  DG5ViewController.m
//  iOS assignment 5
//
//  Created by David Gianforte on 2/28/13.
//  Copyright (c) 2013 David Gianforte. All rights reserved.
//

#import "DG5ViewController.h"

static NSString* const kServerAddress = @"https://weatherparser.herokuapp.com";

@interface DG5ViewController ()
{
    __weak IBOutlet UIActivityIndicatorView *spinner;
    NSMutableArray *dataTypes;
    IBOutlet UITextView *textBox;
    NSString* dataType;
    IBOutlet UIButton *dateButton;
    IBOutlet UIButton *nextButton;
    IBOutlet UIButton *previousButton;
    IBOutlet UIButton *dataButton;
    IBOutlet UIImageView *weatherIcon;
}

@end

@implementation DG5ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(weatherRefreshed:) name:@"weatherRefreshed" object:nil];
    
    dataTypes = [[NSMutableArray alloc] init];
    
    DG5WeatherData *weatherData = [[DG5WeatherData alloc] init];
    
    [weatherData performSelectorInBackground:@selector(refreshWeather) withObject:nil];
    [textBox setText:@"test"];
    UIImage* image = [UIImage imageNamed:@"weather-severe-alert200"];
    weatherIcon.image = image;
}

-(void) setText:(NSString*) s
{
    [textBox setText:[masterWeatherData getData]];
    [dateButton setTitle:[masterWeatherData getDate] forState:UIControlStateNormal];
    [dataButton setTitle:[masterWeatherData getDataTitle] forState:UIControlStateNormal];
    weatherIcon.image = [UIImage imageNamed:[masterWeatherData getIconName]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)nextDate: (UIButton*)sender
{
    [masterWeatherData nextDate];
}

- (IBAction)previousDate: (UIButton*)sender
{
    [masterWeatherData previousDate];
}

-(void) weatherRefreshed:(NSNotification*)note
{
    [spinner stopAnimating];
    NSLog(@"%@", [masterWeatherData getData]);
    [self performSelectorOnMainThread:@selector(setText:) withObject:nil waitUntilDone:YES];
    if ([masterWeatherData getDateInt] == 0)
        [previousButton setEnabled:NO];
    else
        [previousButton setEnabled:YES];
    if ([masterWeatherData getDateInt] == 63)
        [nextButton setEnabled:NO];
    else
        [nextButton setEnabled:YES];
}

@end
