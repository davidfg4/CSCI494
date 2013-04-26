//
//  DGWAGraphViewController.h
//  WeatherApp
//
//  Created by David Gianforte on 4/26/13.
//  Copyright (c) 2013 David Gianforte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"
#import "DGWAWeatherData.h"

@interface DGWAGraphViewController : UIViewController<CPTPlotDataSource, CPTAxisDelegate>
{
    CPTXYGraph *graph;
    
    NSMutableArray *dataForPlot;
}

@property (readwrite, strong, nonatomic) NSMutableArray *dataForPlot;

@end