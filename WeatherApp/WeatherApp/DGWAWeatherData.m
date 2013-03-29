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
}

-(void) refreshWeather
{
    masterWeatherData = self;
    NSData *json = [NSData dataWithContentsOfURL:[NSURL URLWithString:kServerAddress]];
    
    NSError* error = nil;
    id collections = [NSJSONSerialization JSONObjectWithData:json options:kNilOptions error:&error];
    
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

@end
