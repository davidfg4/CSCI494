//
//  DGWALoadingScreenViewController.m
//  WeatherApp
//
//  Created by David Gianforte on 3/29/13.
//  Copyright (c) 2013 David Gianforte. All rights reserved.
//

#import "DGWALoadingScreenViewController.h"

@interface DGWALoadingScreenViewController ()
{
    IBOutlet UIImageView *splashScreen;
}

@end

@implementation DGWALoadingScreenViewController

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
    UIImage *image;
    // http://stackoverflow.com/questions/12446990/how-to-detect-iphone-5-widescreen-devices
    if ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
    {
        image = [UIImage imageNamed:@"Default-568h@2x.png"];
    } else {
        image = [UIImage imageNamed:@"Default"];
    }
    splashScreen.image = image;
    NSLog(@"here");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
