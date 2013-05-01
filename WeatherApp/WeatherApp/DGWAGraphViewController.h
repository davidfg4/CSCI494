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
    
    NSMutableArray *tempData;
    NSMutableArray *tempDevData;
    NSMutableArray *rainData;
    NSMutableArray *snowData;
    NSMutableArray *lineData;
}

@property (readwrite, strong, nonatomic) NSMutableArray *tempData;
@property (readwrite, strong, nonatomic) NSMutableArray *tempDevData;
@property (readwrite, strong, nonatomic) NSMutableArray *rainData;
@property (readwrite, strong, nonatomic) NSMutableArray *snowData;
@property (readwrite, strong, nonatomic) NSMutableArray *lineData;

@end