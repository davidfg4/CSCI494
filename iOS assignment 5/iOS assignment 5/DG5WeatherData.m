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
    NSLog(@"date before: %i", date);
    if (date < 0)
        date = 0;
    NSLog(@"date middle: %i", date);
    if (date > [collections[0][@"values"] count] - 1)
        date = [collections[0][@"values"] count] - 1;
    NSLog(@"date  after: %i", date);
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
-(void) nextDate
{
    [self updateDate:date+1];
}
-(void) previousDate
{
    [self updateDate:date-1];
}
-(NSInteger) getDataInt
{
    return dataSource;
}

-(NSString*) getIconName
{
    int i;
    BOOL day = [collections[dataSource][@"values"][date][@"date"] hasSuffix:@"00:00:00.000Z"] || [collections[dataSource][@"values"][date][@"date"] hasSuffix:@"18:00:00.000Z"]; // is day at noon and 6 pm, MDT
    float snow, rain;
    snow = 0.0;
    rain = 0.0;
    for (i = 0; i < [collections[0][@"values"][date][@"predictions"] count]; i++) {
        snow = snow + [collections[0][@"values"][date][@"predictions"][i] floatValue];
        rain = rain + [collections[1][@"values"][date][@"predictions"][i] floatValue];
        }
    snow = snow / [collections[0][@"values"][date][@"predictions"] count];
    rain = rain / [collections[1][@"values"][date][@"predictions"] count];
    NSLog(@"%f", rain);
    if (snow > .5 && snow > rain) {
        return @"weather-snow200";
    } else if (rain > .5) {
        return @"weather-showers200";
    } else if (day) {
        return @"weather-clear200";
    } else {
        return @"weather-clear-night200";
    }
}

@end