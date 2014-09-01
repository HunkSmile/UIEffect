//
//  AnnularProgressView.m
//
//  Created by Hunk on 12-1-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AnnularProgressView.h"

@interface AnnularProgressView ()
{
    CGFloat _color[4];
}

- (void)rgbColorFromUIColor:(UIColor *)color;

@end

@implementation AnnularProgressView
@synthesize progress            = _progress;
@synthesize progressTintColor   = _progressTintColor;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) 
    {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    
    [self setNeedsDisplay];
}

- (void)setProgressTintColor:(UIColor *)progressTintColor
{
    _progressTintColor = progressTintColor;
    
    [self rgbColorFromUIColor:_progressTintColor];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{   
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    CGContextSetRGBFillColor(contextRef, _color[0], _color[1], _color[2], _color[3]);
    
    CGContextMoveToPoint(contextRef, self.frame.size.width / 2, self.frame.size.height / 2);
    
    CGContextAddArc(contextRef, 
                    self.frame.size.width / 2, 
                    self.frame.size.height / 2,
                    30,
                    - M_PI / 2,
                    _progress * 2 * M_PI - M_PI / 2, 
                    0);
    
    CGContextClosePath(contextRef);
    
    CGContextDrawPath(contextRef, kCGPathFill);
}

// Change UIColor to RGB(A)
- (void)rgbColorFromUIColor:(UIColor *)color
{
    NSString* colorValue = [NSString stringWithFormat:@"%@", color];
    
    NSArray *array = [colorValue componentsSeparatedByString:@" "];
    
    _color[0] = [[array objectAtIndex:1] floatValue];
    _color[1] = [[array objectAtIndex:2] floatValue];
    _color[2] = [[array objectAtIndex:3] floatValue];
    _color[3] = 1.0f;//[[array objectAtIndex:3] floatValue];
}

@end
