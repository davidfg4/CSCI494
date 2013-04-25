//
//  DGWAWeatherData.m
//  WeatherApp
//
//  Created by David Gianforte on 3/29/13.
//  Copyright (c) 2013 David Gianforte. All rights reserved.
//

#import "DGWAWeatherData.h"

static NSString* const kServerAddress = @"https://weatherparser.herokuapp.com";

@implementation DGWAWeatherData
{
    NSMutableArray *dataTypes;
    id collections;
    NSInteger date;
}

-(void) refreshWeather
{
    masterWeatherData = self;
    date = 0;
    NSData *json = [NSData dataWithContentsOfURL:[NSURL URLWithString:kServerAddress]];
    
    NSError* error = nil;
    collections = [NSJSONSerialization JSONObjectWithData:json options:kNilOptions error:&error];
    
    if (error)
    {
        return;
    }
    
    dataTypes = [[NSMutableArray alloc] init];
    
    for( NSDictionary *variable in collections ) {
        NSLog( @"%@", variable[@"variable"] );
        [dataTypes addObject:variable[@"variable"]];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"weatherRefreshed" object:nil];
}

// 0 == now, 1 == tomorrow
-(void) setWeatherTime: (NSInteger) weatherTime
{
    if (weatherTime == 0)
    {
        date = 0;
    } else {
        // TODO: fixme
        date = 2;
        while ([collections[0][@"values"][date][@"date"] hasSuffix:@"18:00:00.000Z"] == FALSE) {
            date++;
        }
    }
}

-(NSString*) getWeatherName
{
    return collections[0][@"values"][date][@"date"];
}

-(float) getAvgTemp
{
    NSInteger i;
    float average;
    for (i = 0; i < [collections[3][@"values"][date][@"predictions"] count]; i++) {
        average = average + [collections[3][@"values"][date][@"predictions"][i] floatValue];
        average = average + [collections[4][@"values"][date][@"predictions"][i] floatValue];
    }
    return average / (2 * [collections[3][@"values"][date][@"predictions"] count]);
}

-(float) KtoF:(float)k
{
    return k * 9.0/5.0 - 459.67;
}

-(float) KtoC:(float)k
{
    return k - 273.15;
}

@end
