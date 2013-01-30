//
//  DG1ViewController.h
//  iOS application 1
//
//  Created by David Gianforte on 1/30/13.
//  Copyright (c) 2013 David Gianforte. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DG1ViewController : UIViewController
{
    @private
    IBOutlet UILabel *label;
    IBOutlet UIButton *button;
    BOOL labelChanged;
}

-(IBAction) pressedButton;

@end
