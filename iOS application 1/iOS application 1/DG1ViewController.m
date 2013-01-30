//
//  DG1ViewController.m
//  iOS application 1
//
//  Created by David Gianforte on 1/30/13.
//  Copyright (c) 2013 David Gianforte. All rights reserved.
//

#import "DG1ViewController.h"

@interface DG1ViewController ()

@end

@implementation DG1ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    DLog("view controller has loaded");
    labelChanged = false;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) pressedButton
{
    DLog("button pressed");
    if (labelChanged) {
        label.text = @"iOS assignment 1";
    } else {
        label.text = @"You win!";
    }
    labelChanged = !labelChanged;
}

@end
