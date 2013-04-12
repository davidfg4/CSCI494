//
//  DGWAWeatherScrollView.m
//  WeatherApp
//
//  Created by David Gianforte on 3/29/13.
//  Copyright (c) 2013 David Gianforte. All rights reserved.
//

#import "DGWAWeatherScrollView.h"

@implementation DGWAWeatherScrollView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.contentSize=CGSizeMake(1280,960);
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
