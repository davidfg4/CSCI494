//
//  DG2patternSubView.m
//  iOS assignment 2
//
//  Created by David Gianforte on 1/31/13.
//  Copyright (c) 2013 David Gianforte. All rights reserved.
//

#import "DG2patternSubView.h"

@implementation DG2patternSubView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    [[UIColor orangeColor] set];
    [path stroke];
}


-(void) awakeFromNib
{
    [self changePattern:0];

}

-(void) changePattern:(NSInteger)p
{
    pattern = p;
    dispatch_async( dispatch_get_main_queue(), ^{
        if (pattern == 0)
        {
            path = [UIBezierPath new];
            [path moveToPoint:CGPointMake(0.0, 0.0)];
            [path addLineToPoint:CGPointMake(self.bounds.size.width, self.bounds.size.height)];
        } else if (pattern == 1) {
            path = [UIBezierPath bezierPathWithOvalInRect:self.bounds];
        } else if (pattern == 2) {
            path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) radius:40.0 startAngle:3.1415*1.5 endAngle:3.1415*3.0 clockwise:true];
        }
        path.lineWidth = 5.0;
        
        [self setNeedsDisplay];
    });
}

@end
