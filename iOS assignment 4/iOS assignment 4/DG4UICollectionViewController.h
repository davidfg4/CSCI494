//
//  DG4UICollectionViewController.h
//  iOS assignment 4
//
//  Created by David Gianforte on 2/17/13.
//  Copyright (c) 2013 David Gianforte. All rights reserved.
//

#import <UIKit/UIKit.h>
#define NUMCOLS 10

@interface DG4UICollectionViewController : UICollectionViewController

@end

NSInteger selectedInCol[NUMCOLS];
UIColor *selectedColor, *deselectedColor;