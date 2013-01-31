//
//  DG2ViewController.m
//  iOS assignment 2
//
//  Created by David Gianforte on 1/30/13.
//  Copyright (c) 2013 David Gianforte. All rights reserved.
//

#import "DG2ViewController.h"

@interface DG2ViewController ()

@end

@implementation DG2ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    topPattern = 0;
    [self cyclePatterns];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) cyclePatterns
{
    [view0 changePattern:topPattern];
    [view1 changePattern:(topPattern+1)%3];
    [view2 changePattern:(topPattern+2)%3];
    topPattern = (topPattern + 2) % 3;
    DLog("pressed button");
}

@end
