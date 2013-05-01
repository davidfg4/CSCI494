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
    id tmin2m;
    id tmax2m;
    id crainsfc;
    id csnowsfc;
    id sunsdsfc;
    id apcpsfc;
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
        if ([variable[@"variable"] isEqualToString:@"tmin2m"])
            tmin2m = variable[@"values"];
        if ([variable[@"variable"] isEqualToString:@"tmax2m"])
            tmax2m = variable[@"values"];
        if ([variable[@"variable"] isEqualToString:@"crainsfc"])
            crainsfc = variable[@"values"];
        if ([variable[@"variable"] isEqualToString:@"csnowsfc"])
            csnowsfc = variable[@"values"];
        if ([variable[@"variable"] isEqualToString:@"sunsdsfc"])
            sunsdsfc = variable[@"values"];
        if ([variable[@"variable"] isEqualToString:@"apcpsfc"])
            apcpsfc = variable[@"values"];
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
    for (i = 0; i < [tmin2m[date][@"predictions"] count]; i++) {
        average = average + [tmin2m[date][@"predictions"][i] floatValue];
        average = average + [tmax2m[date][@"predictions"][i] floatValue];
    }
    return average / (2 * [tmin2m[date][@"predictions"] count]);
}

-(NSString*) getIconName
{
    BOOL day = [crainsfc[date][@"date"] hasSuffix:@"00:00:00.000Z"] || [collections[0][@"values"][date][@"date"] hasSuffix:@"18:00:00.000Z"]; // is day at noon and 6 pm, MDT
    float snow, rain;
    snow = [self getSnowChance];
    rain = [self getRainChance];
    //NSLog(@"%f", rain);
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

-(float) getRainChance
{
    int i;
    float rain;
    rain = 0.0;
    for (i = 0; i < [crainsfc[date][@"predictions"] count]; i++) {
        rain = rain + [crainsfc[date][@"predictions"][i] floatValue];
    }
    rain = rain / [crainsfc[date][@"predictions"] count];
    return rain;
}

-(float) getSnowChance
{
    int i;
    float snow;
    snow = 0.0;
    for (i = 0; i < [crainsfc[date][@"predictions"] count]; i++) {
        snow = snow + [csnowsfc[date][@"predictions"][i] floatValue];
    }
    snow = snow / [csnowsfc[date][@"predictions"] count];
    return snow;
}

-(NSMutableArray *) getTemps
{
    int i, j;
    NSMutableArray *temps = [NSMutableArray arrayWithCapacity:100];
    for (i = 0; i < [tmin2m count]; i++) {
        id x = [NSNumber numberWithFloat:0 + i * 0.25];
        float yfloat = 0.0;
        for (j = 0; j < [tmin2m[i][@"predictions"] count]; j++)
        {
            yfloat = yfloat + [self KtoF:[tmin2m[i][@"predictions"][j] floatValue]];
            yfloat = yfloat + [self KtoF:[tmax2m[i][@"predictions"][j] floatValue]];
        }
        yfloat = yfloat / ([tmax2m[0][@"predictions"] count] * 2);
        id y = [NSNumber numberWithFloat:yfloat];
        [temps addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:x, @"x", y, @"y", nil]];
    }
    return temps;
}

-(NSMutableArray *) getRains
{
    int i, j;
    NSMutableArray *rains = [NSMutableArray arrayWithCapacity:100];
    for (i = 0; i < [crainsfc count]; i++) {
        id x = [NSNumber numberWithFloat:0 + i * 0.25];
        float yfloat = 0.0;
        for (j = 0; j < [crainsfc[i][@"predictions"] count]; j++)
        {
            yfloat = yfloat + [crainsfc[i][@"predictions"][j] floatValue];
        }
        yfloat = yfloat * 20 / [crainsfc[0][@"predictions"] count];
        id y = [NSNumber numberWithFloat:yfloat];
        [rains addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:x, @"x", y, @"y", nil]];
    }
    return rains;
}

-(NSMutableArray *) getSnows
{
    int i, j;
    NSMutableArray *snows = [NSMutableArray arrayWithCapacity:100];
    for (i = 0; i < [csnowsfc count]; i++) {
        id x = [NSNumber numberWithFloat:0 + i * 0.25];
        float yfloat = 0.0;
        for (j = 0; j < [csnowsfc[i][@"predictions"] count]; j++)
        {
            yfloat = yfloat + [csnowsfc[i][@"predictions"][j] floatValue];
        }
        yfloat = yfloat * 20 / [csnowsfc[0][@"predictions"] count];
        id y = [NSNumber numberWithFloat:yfloat];
        [snows addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:x, @"x", y, @"y", nil]];
    }
    return snows;
}

-(NSMutableArray *) getTempDeviation
{
    int i, j;
    NSMutableArray *temps = [NSMutableArray arrayWithCapacity:100];
    for (i = 0; i < [tmin2m count]; i++) {
        id x = [NSNumber numberWithFloat:0 + i * 0.25];
        float yavg = 0.0;
        for (j = 0; j < [tmin2m[i][@"predictions"] count]; j++)
        {
            yavg = yavg + [self KtoF:[tmin2m[i][@"predictions"][j] floatValue]];
            yavg = yavg + [self KtoF:[tmax2m[i][@"predictions"][j] floatValue]];
        }
        yavg = yavg / ([tmax2m[0][@"predictions"] count] * 2);
        float stddev = 0.0;
        for (j = 0; j < [tmin2m[i][@"predictions"] count]; j++)
        {
            float t = [self KtoF:[tmin2m[i][@"predictions"][j] floatValue]] - yavg;
            stddev = stddev + (t * t);
            t = [self KtoF:[tmax2m[i][@"predictions"][j] floatValue]] - yavg;
            stddev = stddev + (t * t);
        }
        stddev = sqrt(stddev / ([tmax2m[0][@"predictions"] count] * 2));
        id y = [NSNumber numberWithFloat:yavg];
        [temps addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:x, @"x", y, @"y", nil]];
        y = [NSNumber numberWithFloat:(yavg + stddev)];
        [temps addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:x, @"x", y, @"y", nil]];
        y = [NSNumber numberWithFloat:(yavg - stddev)];
        [temps addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:x, @"x", y, @"y", nil]];
        y = [NSNumber numberWithFloat:yavg];
        [temps addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:x, @"x", y, @"y", nil]];
    }
    return temps;
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
