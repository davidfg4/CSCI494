//
//  DG2ViewController.h
//  iOS assignment 2
//
//  Created by David Gianforte on 1/30/13.
//  Copyright (c) 2013 David Gianforte. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DG2patternSubView.h"

@interface DG2ViewController : UIViewController
{
    IBOutlet DG2patternSubView *view0;
    IBOutlet DG2patternSubView *view1;
    IBOutlet DG2patternSubView *view2;
    NSInteger topPattern;
}

@end
