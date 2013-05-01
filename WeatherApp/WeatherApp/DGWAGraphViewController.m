//
//  DGWAGraphViewController.m
//  WeatherApp
//
//  Created by David Gianforte on 4/26/13.
//  Copyright (c) 2013 David Gianforte. All rights reserved.
//

#import "DGWAGraphViewController.h"

@implementation DGWAGraphViewController
{
    IBOutlet CPTGraphHostingView *graphView;
}

@synthesize tempData;
@synthesize tempDevData;
@synthesize rainData;
@synthesize snowData;
@synthesize lineData;
@synthesize rainDevData;
@synthesize snowDevData;

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

#pragma mark -
#pragma mark Initialization and teardown

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    // Create graph from theme
    graph = [[CPTXYGraph alloc] initWithFrame:CGRectZero];
    CPTTheme *theme = [CPTTheme themeNamed:kCPTPlainWhiteTheme];
    //kCPTDarkGradientTheme, kCPTPlainBlackTheme, kCPTPlainWhiteTheme, kCPTSlateTheme, and kCPTStocksTheme
    [graph applyTheme:theme];
    CPTGraphHostingView *hostingView = (CPTGraphHostingView *)graphView;
    hostingView.collapsesLayers = NO; // Setting to YES reduces GPU memory usage, but can slow drawing/scrolling
    hostingView.hostedGraph     = graph;
    
    graph.paddingLeft   = 0.0;
    graph.paddingTop    = 0.0;
    graph.paddingRight  = 0.0;
    graph.paddingBottom = 0.0;
    
    // Setup plot space
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    plotSpace.allowsUserInteraction = YES;
    plotSpace.xRange                = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(-0.5) length:CPTDecimalFromFloat(4.0)];
    plotSpace.yRange                = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(-10.0) length:CPTDecimalFromFloat(100.0)];
    
    // Axes
    CPTXYAxisSet *axisSet = (CPTXYAxisSet *)graph.axisSet;
    CPTXYAxis *x          = axisSet.xAxis;
    x.majorIntervalLength         = CPTDecimalFromString(@"1.0");
    x.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
    x.minorTicksPerInterval       = 3;
    
    CPTXYAxis *y = axisSet.yAxis;
    y.majorIntervalLength         = CPTDecimalFromString(@"10.0");
    y.minorTicksPerInterval       = 9;
    y.orthogonalCoordinateDecimal = CPTDecimalFromString(@"0");
    y.delegate             = self;
    
    // Graph dotted line
    CPTScatterPlot *dataSourceLinePlot = [[CPTScatterPlot alloc] init];
    CPTMutableLineStyle *lineStyle   = [CPTMutableLineStyle lineStyle];
    lineStyle.lineWidth              = 1.0f;
    lineStyle.lineColor              = [CPTColor blackColor];
    lineStyle.dashPattern            = [NSArray arrayWithObjects:[NSNumber numberWithFloat:5.0f], [NSNumber numberWithFloat:5.0f], nil];
    dataSourceLinePlot.dataLineStyle = lineStyle;
    dataSourceLinePlot.identifier    = @"Line";
    dataSourceLinePlot.dataSource    = self;
    [graph addPlot:dataSourceLinePlot];
    
    // Graph snow std deviation
    dataSourceLinePlot = [[CPTScatterPlot alloc] init];
    lineStyle   = [CPTMutableLineStyle lineStyle];
    lineStyle.miterLimit             = 1.0f;
    lineStyle.lineWidth              = 0.5f;
    lineStyle.lineColor              = [CPTColor blueColor];
    dataSourceLinePlot.dataLineStyle = lineStyle;
    dataSourceLinePlot.identifier    = @"Snow Dev";
    dataSourceLinePlot.dataSource    = self;
    [graph addPlot:dataSourceLinePlot];
    
    // Graph snow
    dataSourceLinePlot = [[CPTScatterPlot alloc] init];
    lineStyle   = [CPTMutableLineStyle lineStyle];
    lineStyle.miterLimit             = 1.0f;
    lineStyle.lineWidth              = 3.0f;
    lineStyle.lineColor              = [CPTColor blueColor];
    dataSourceLinePlot.dataLineStyle = lineStyle;
    dataSourceLinePlot.identifier    = @"Snow";
    dataSourceLinePlot.dataSource    = self;
    [graph addPlot:dataSourceLinePlot];
    
    // Graph rain std deviation
    dataSourceLinePlot = [[CPTScatterPlot alloc] init];
    lineStyle   = [CPTMutableLineStyle lineStyle];
    lineStyle.miterLimit             = 1.0f;
    lineStyle.lineWidth              = 0.5f;
    lineStyle.lineColor              = [CPTColor greenColor];
    dataSourceLinePlot.dataLineStyle = lineStyle;
    dataSourceLinePlot.identifier    = @"Rain Dev";
    dataSourceLinePlot.dataSource    = self;
    [graph addPlot:dataSourceLinePlot];
    
    // Graph rain
    dataSourceLinePlot = [[CPTScatterPlot alloc] init];
    lineStyle   = [CPTMutableLineStyle lineStyle];
    lineStyle.miterLimit             = 1.0f;
    lineStyle.lineWidth              = 3.0f;
    lineStyle.lineColor              = [CPTColor greenColor];
    dataSourceLinePlot.dataLineStyle = lineStyle;
    dataSourceLinePlot.identifier    = @"Rain";
    dataSourceLinePlot.dataSource    = self;
    [graph addPlot:dataSourceLinePlot];
    
    // Graph temp std deviation
    dataSourceLinePlot = [[CPTScatterPlot alloc] init];
    lineStyle   = [CPTMutableLineStyle lineStyle];
    lineStyle.miterLimit             = 1.0f;
    lineStyle.lineWidth              = 0.5f;
    lineStyle.lineColor              = [CPTColor redColor];
    dataSourceLinePlot.dataLineStyle = lineStyle;
    dataSourceLinePlot.identifier    = @"Temp Std Dev";
    dataSourceLinePlot.dataSource    = self;
    [graph addPlot:dataSourceLinePlot];
    
    // Graph temperatures
    CPTScatterPlot *boundLinePlot  = [[CPTScatterPlot alloc] init];
    lineStyle = [CPTMutableLineStyle lineStyle];
    lineStyle.miterLimit        = 1.0f;
    lineStyle.lineWidth         = 3.0f;
    lineStyle.lineColor         = [CPTColor redColor];
    boundLinePlot.dataLineStyle = lineStyle;
    boundLinePlot.identifier    = @"Temp Avg";
    boundLinePlot.dataSource    = self;
    [graph addPlot:boundLinePlot];
    
    // Do a blue gradient
    /*
    CPTColor *areaColor1       = [CPTColor colorWithComponentRed:0.3 green:0.3 blue:1.0 alpha:0.8];
    CPTGradient *areaGradient1 = [CPTGradient gradientWithBeginningColor:areaColor1 endingColor:[CPTColor clearColor]];
    areaGradient1.angle = -90.0f;
    CPTFill *areaGradientFill = [CPTFill fillWithGradient:areaGradient1];
    boundLinePlot.areaFill      = areaGradientFill;
    boundLinePlot.areaBaseValue = [[NSDecimalNumber zero] decimalValue];
     */
    
    // Add plot symbols
    /*
    CPTMutableLineStyle *symbolLineStyle = [CPTMutableLineStyle lineStyle];
    symbolLineStyle.lineColor = [CPTColor blackColor];
    CPTPlotSymbol *plotSymbol = [CPTPlotSymbol ellipsePlotSymbol];
    plotSymbol.fill          = [CPTFill fillWithColor:[CPTColor blueColor]];
    plotSymbol.lineStyle     = symbolLineStyle;
    plotSymbol.size          = CGSizeMake(5.0, 5.0);
    boundLinePlot.plotSymbol = plotSymbol;
     */
    

     
    
    // Put an area gradient under the plot above
    /*
    CPTColor *areaColor       = [CPTColor colorWithComponentRed:0.3 green:1.0 blue:0.3 alpha:0.8];
    CPTGradient *areaGradient = [CPTGradient gradientWithBeginningColor:areaColor endingColor:[CPTColor clearColor]];
    areaGradient.angle               = -90.0f;
    areaGradientFill                 = [CPTFill fillWithGradient:areaGradient];
    dataSourceLinePlot.areaFill      = areaGradientFill;
    dataSourceLinePlot.areaBaseValue = CPTDecimalFromString(@"1.75");
     */
    
    // Add some initial data
    self.tempData = [masterWeatherData getTemps];
    self.tempDevData = [masterWeatherData getTempDeviation];
    self.rainData = [masterWeatherData getRains];
    self.snowData = [masterWeatherData getSnows];
    self.rainDevData = [masterWeatherData getRainDeviation];
    self.snowDevData = [masterWeatherData getSnowDeviation];
    
    self.lineData = [NSMutableArray arrayWithCapacity:100];
    id xid = [NSNumber numberWithFloat:0];
    id yid = [NSNumber numberWithFloat:20];
    [self.lineData addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:xid, @"x", yid, @"y", nil]];
    xid = [NSNumber numberWithFloat:15.75];
    [self.lineData addObject:[NSMutableDictionary dictionaryWithObjectsAndKeys:xid, @"x", yid, @"y", nil]];
    
#ifdef PERFORMANCE_TEST
    [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(changePlotRange) userInfo:nil repeats:YES];
#endif
}

-(void)changePlotRange
{
    // Setup plot space
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *)graph.defaultPlotSpace;
    
    plotSpace.xRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0) length:CPTDecimalFromFloat(3.0 + 2.0 * rand() / RAND_MAX)];
    plotSpace.yRange = [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat(0.0) length:CPTDecimalFromFloat(3.0 + 2.0 * rand() / RAND_MAX)];
}

#pragma mark -
#pragma mark Plot Data Source Methods

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plot
{
    if ( [(NSString *)plot.identifier isEqualToString:@"Temp Std Dev"] ) {
        return [tempDevData count];
    } else if ( [(NSString *)plot.identifier isEqualToString:@"Rain"] ) {
        return [rainData count];
    } else if ( [(NSString *)plot.identifier isEqualToString:@"Snow"] ) {
        return [snowData count];
    } else if ( [(NSString *)plot.identifier isEqualToString:@"Line"] ) {
        return [lineData count];
    } else if ( [(NSString *)plot.identifier isEqualToString:@"Rain Dev"] ) {
        return [rainDevData count];
    } else if ( [(NSString *)plot.identifier isEqualToString:@"Snow Dev"] ) {
        return [snowDevData count];
    }
    return [tempData count];
}

-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{
    NSString *key = (fieldEnum == CPTScatterPlotFieldX ? @"x" : @"y");
    NSNumber *num;
    
    if ( [(NSString *)plot.identifier isEqualToString:@"Temp Std Dev"] ) {
        num = [[tempDevData objectAtIndex:index] valueForKey:key];
    } else if ( [(NSString *)plot.identifier isEqualToString:@"Temp Avg"] ) {
        num = [[tempData objectAtIndex:index] valueForKey:key];
    } else if ( [(NSString *)plot.identifier isEqualToString:@"Rain"] ) {
        num = [[rainData objectAtIndex:index] valueForKey:key];
    } else if ( [(NSString *)plot.identifier isEqualToString:@"Snow"] ) {
        num = [[snowData objectAtIndex:index] valueForKey:key];
    } else if ( [(NSString *)plot.identifier isEqualToString:@"Line"] ) {
        num = [[lineData objectAtIndex:index] valueForKey:key];
    } else if ( [(NSString *)plot.identifier isEqualToString:@"Rain Dev"] ) {
        num = [[rainDevData objectAtIndex:index] valueForKey:key];
    }else if ( [(NSString *)plot.identifier isEqualToString:@"Snow Dev"] ) {
        num = [[snowDevData objectAtIndex:index] valueForKey:key];
    }
    return num;
}

#pragma mark -
#pragma mark Axis Delegate Methods

-(BOOL)axis:(CPTAxis *)axis shouldUpdateAxisLabelsAtLocations:(NSSet *)locations
{
    NSFormatter *formatter = axis.labelFormatter;
    CGFloat labelOffset    = axis.labelOffset;
    
    NSMutableSet *newLabels = [NSMutableSet set];
    
    for ( NSDecimalNumber *tickLocation in locations ) {
        CPTTextStyle *theLabelTextStyle;
        
        CPTMutableTextStyle *newStyle = [axis.labelTextStyle mutableCopy];
        newStyle.color = [CPTColor blackColor];
        theLabelTextStyle = newStyle;
        
        NSString *labelString       = [formatter stringForObjectValue:tickLocation];
        CPTTextLayer *newLabelLayer = [[CPTTextLayer alloc] initWithText:labelString style:theLabelTextStyle];
        
        CPTAxisLabel *newLabel = [[CPTAxisLabel alloc] initWithContentLayer:newLabelLayer];
        newLabel.tickLocation = tickLocation.decimalValue;
        newLabel.offset       = labelOffset;
        
        [newLabels addObject:newLabel];
    }
    
    axis.axisLabels = newLabels;
    
    return NO;
}

@end