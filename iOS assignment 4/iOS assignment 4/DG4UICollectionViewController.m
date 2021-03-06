//
//  DG4UICollectionViewController.m
//  iOS assignment 4
//
//  Created by David Gianforte on 2/17/13.
//  Copyright (c) 2013 David Gianforte. All rights reserved.
//

// Good job, 100%.

#import "DG4UICollectionViewController.h"

@interface DG4UICollectionViewController ()

@end

@implementation DG4UICollectionViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    for (NSInteger i = 0; i < NUMCOLS; i++)
    {
        selectedInCol[i] = -1;
    }
    selectedColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1.0];
    deselectedColor = [UIColor blueColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return NUMCOLS;
}

-(NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 7;
}

-(void) collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        NSInteger col = [indexPath indexAtPosition:0];
    NSInteger row = [indexPath indexAtPosition:1];
    DLog("col %i, row %i pressed", col, row);
    if (selectedInCol[col] == row)
    {
        return;
    }
    if (selectedInCol[col] != -1)
    {
        NSUInteger oldCellArray[2];
        oldCellArray[0] = col;
        oldCellArray[1] = selectedInCol[col];
        NSIndexPath *oldCellIndexPath = [NSIndexPath indexPathWithIndexes:oldCellArray length:2];
        UICollectionViewCell *oldCell = [collectionView cellForItemAtIndexPath:oldCellIndexPath];
        oldCell.backgroundColor = deselectedColor;
    }
    cell.backgroundColor = selectedColor;
    selectedInCol[col] = row;
}

-(UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    NSInteger col = [indexPath indexAtPosition:0];
    NSInteger row = [indexPath indexAtPosition:1];
    if (selectedInCol[col] == row)
    {
        cell.backgroundColor = selectedColor;
    } else {
        cell.backgroundColor = deselectedColor;
    }
    return cell;
}

@end
