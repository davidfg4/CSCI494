//
//  DG5WeatherData.m
//  iOS assignment 5
//
//  Created by David Gianforte on 2/28/13.
//  Copyright (c) 2013 David Gianforte. All rights reserved.
//

#import "DG5WeatherData.h"

static NSString* const kServerAddress = @"https://weatherparser.herokuapp.com";

@implementation DG5WeatherData
{
    NSMutableArray *dataTypes;
    NSInteger dataSource;
    NSInteger date;
}

-(void) awakeFromNib
{
    dataSource = 0;
    date = 0;
}

-(void) refreshWeather
{
    masterWeatherData = self;
    NSData *json = [NSData dataWithContentsOfURL:[NSURL URLWithString:kServerAddress]];
    
    NSError* error = nil;
    collections = [NSJSONSerialization JSONObjectWithData:json options:kNilOptions error:&error];
    
    if (error)
    {
        return;
    }
    
    dataTypes = [[NSMutableArray alloc] init];
    
    //currentForecast = [NSMutableDictionary new];
    for( NSDictionary *variable in collections ) {
        //NSArray *predictions = [EWWeatherPrediction newWeatherPredictionsFromDictionary:variable];
        //currentForecast[variable[@"variable"]] = predictions;
        NSLog( @"%@", variable[@"variable"] );
        [dataTypes addObject:variable[@"variable"]];
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"weatherRefreshed" object:nil];
}

-(NSString*) getData
{
    //return collections[dataSource][@"values"];
    return [[collections[dataSource][@"values"][date] valueForKey:@"predictions"] componentsJoinedByString:@", "];
}

-(void) updateDataSource:(NSInteger) i
{
    dataSource = i;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"weatherRefreshed" object:nil];
}

-(void) updateDate:(NSInteger) i
{
    date = i;
    [[NSNotificationCenter defaultCenter] postNotificationName:@"weatherRefreshed" object:nil];
}

-(NSString*) getDate
{
    return collections[dataSource][@"values"][date][@"date"];
}
-(NSString*) getDataTitle
{
    return collections[dataSource][@"variable"];
}
-(NSInteger) getDateInt
{
    return date;
}
-(NSInteger) getDataInt
{
    return dataSource;
}

@end