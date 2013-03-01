//
//  DG5WeatherData.h
//  iOS assignment 5
//
//  Created by David Gianforte on 2/28/13.
//  Copyright (c) 2013 David Gianforte. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DG5WeatherData : NSObject

-(NSString*) getData;
-(void) updateDataSource:(NSInteger) i;
-(void) updateDate:(NSInteger) i;
-(NSString*) getDate;
-(NSString*) getDataTitle;
-(NSInteger) getDateInt;
-(NSInteger) getDataInt;

@end

id collections;

DG5WeatherData *masterWeatherData;