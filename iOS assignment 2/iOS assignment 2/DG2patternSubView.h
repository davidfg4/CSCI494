//
//  DG2patternSubView.h
//  iOS assignment 2
//
//  Created by David Gianforte on 1/31/13.
//  Copyright (c) 2013 David Gianforte. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DG2patternSubView : UIView
{
    NSInteger pattern;
    UIBezierPath *path;
}

-(void) changePattern:(NSInteger)p;

@end
