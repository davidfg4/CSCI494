//
//  DGWAWeatherData.h
//  WeatherApp
//
//  Created by David Gianforte on 3/29/13.
//  Copyright (c) 2013 David Gianforte. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DGWAWeatherData : NSObject

-(void) setWeatherTime: (NSInteger) weatherTime;
-(NSString*) getWeatherName;

-(float) getAvgTemp;
-(NSString*) getIconName;
-(float) getRainChance;
-(float) getSnowChance;

-(NSMutableArray *) getTemps;
-(NSMutableArray *) getTempDeviation;
-(NSMutableArray *) getRains;
-(NSMutableArray *) getSnows;
-(NSMutableArray *) getRainDeviation;
-(NSMutableArray *) getSnowDeviation;

-(float) KtoF:(float)k;
-(float) KtoC:(float)k;

@end

DGWAWeatherData *masterWeatherData;

