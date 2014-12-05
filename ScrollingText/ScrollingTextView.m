//
//  ScrollingTextView.m
//  ScrollingText
//
//  Created by Hunk on 14/12/1.
//  Copyright (c) 2014年 Hunk. All rights reserved.
//

#import "ScrollingTextView.h"

@interface ScrollingTextView ()
{
    // Text label
    UILabel     *_textLabel[2];
    
    // Text index
    NSInteger    _index;
    
    BOOL         _animatingEnable;
}
@end

@implementation ScrollingTextView
@synthesize scrollingTextArray  = _scrollingTextArray;
@synthesize scrollDirection     = _scrollDirection;
@synthesize duration            = _duration;
@synthesize isAnimating         = _isAnimating;

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self setBackgroundColor:[UIColor clearColor]];
        [self setClipsToBounds:YES];
        [self setOpaque:YES];
        
        // Text label
        _textLabel[0] = [self textLabelWithFrame:self.bounds];
        [self addSubview:_textLabel[0]];
        
        _textLabel[1] = [self textLabelWithFrame:CGRectMake(CGRectGetWidth(self.bounds), 0.0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
        [self addSubview:_textLabel[1]];
        
        // Initialize data
        self.scrollingTextArray = @[@"DefaultScrollingText-1", @"DefaultScrollingText-2"];
        self.scrollDirection    = ScrollDirectionFromLeftToRight;
        self.duration           = 2.0;
        self.isAnimating        = NO;
        _index                  = 0;
        _animatingEnable        = YES;
    }
    return self;
}

#pragma mark -
#pragma mark Set scroll text array
-(void)setScrollingTextArray:(NSArray *)scrollingTextArray
{
    if(_scrollingTextArray != scrollingTextArray)
    {
        _scrollingTextArray = scrollingTextArray;
    }
    
    if([_scrollingTextArray count] >= 2)
    {
        [_textLabel[0] setText:[_scrollingTextArray objectAtIndex:0]];
        [_textLabel[1] setText:[_scrollingTextArray objectAtIndex:1]];
        _index = 1;
    }
}

#pragma mark -
#pragma mark Set scroll direction
- (void)setScrollDirection:(ScrollDirection)scrollDirection
{
    _scrollDirection = scrollDirection;
    
    switch(self.scrollDirection)
    {
        case ScrollDirectionFromRightToLeft:
        {
            [_textLabel[0] setFrame:self.bounds];
            [_textLabel[1] setFrame:CGRectMake(CGRectGetWidth(self.bounds), 0.0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
        }
            break;
        case ScrollDirectionFromLeftToRight:
        {
            [_textLabel[0] setFrame:self.bounds];
            [_textLabel[1] setFrame:CGRectMake(-CGRectGetWidth(self.bounds), 0.0, CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
        }
            break;
        case ScrollDirectionFromTopToBottom:
        {
            [_textLabel[0] setFrame:self.bounds];
            [_textLabel[1] setFrame:CGRectMake(0.0, -CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
        }
            break;
        case ScrollDirectionFromBottomToTop:
        {
            [_textLabel[0] setFrame:self.bounds];
            [_textLabel[1] setFrame:CGRectMake(0.0, CGRectGetHeight(self.bounds), CGRectGetWidth(self.bounds), CGRectGetHeight(self.bounds))];
        }
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark Start animating
- (void)startAnimating
{
    _animatingEnable = YES;
    [self setIsAnimating:YES];
    
    [UIView animateWithDuration:self.duration
                          delay:0.0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         switch(self.scrollDirection)
                         {
                             case ScrollDirectionFromRightToLeft:
                             {
                                 [_textLabel[0] setFrame:CGRectOffset(_textLabel[0].frame, -CGRectGetWidth(self.bounds), 0.0)];
                                 [_textLabel[1] setFrame:CGRectOffset(_textLabel[1].frame, -CGRectGetWidth(self.bounds), 0.0)];
                             }
                                 break;
                             case ScrollDirectionFromLeftToRight:
                             {
                                 [_textLabel[0] setFrame:CGRectOffset(_textLabel[0].frame, CGRectGetWidth(self.bounds), 0.0)];
                                 [_textLabel[1] setFrame:CGRectOffset(_textLabel[1].frame, CGRectGetWidth(self.bounds), 0.0)];
                             }
                                 break;
                             case ScrollDirectionFromTopToBottom:
                             {
                                 [_textLabel[0] setFrame:CGRectOffset(_textLabel[0].frame, 0.0, CGRectGetHeight(self.bounds))];
                                 [_textLabel[1] setFrame:CGRectOffset(_textLabel[1].frame, 0.0, CGRectGetHeight(self.bounds))];
                             }
                                 break;
                             case ScrollDirectionFromBottomToTop:
                             {
                                 [_textLabel[0] setFrame:CGRectOffset(_textLabel[0].frame, 0.0, -CGRectGetHeight(self.bounds))];
                                 [_textLabel[1] setFrame:CGRectOffset(_textLabel[1].frame, 0.0, -CGRectGetHeight(self.bounds))];
                             }
                                 break;
                             default:
                                 break;
                         }
                     }
                     completion:^(BOOL finished) {
                         [self setIsAnimating:NO];
                         if(YES == _animatingEnable)
                         {
                             [self animationDidStoped];
                         }
                     }];
}

- (BOOL)stopAnimating
{
    if(self.isAnimating)
    {
        _animatingEnable = NO;
        
        return YES;
    }
    return NO;
}

#pragma makr -
#pragma makr Private method
// Animation stoped
- (void)animationDidStoped
{
    _index++;
    if(_index >= [_scrollingTextArray count])
    {
        _index = 0;
    }
    
    if([_scrollingTextArray count] > _index)
    {
        switch(self.scrollDirection)
        {
            case ScrollDirectionFromRightToLeft:
            {
                if(_textLabel[0].frame.origin.x < 0)
                {
                    [_textLabel[0] setFrame:CGRectOffset(_textLabel[0].frame, 2 * CGRectGetWidth(self.bounds), 0.0)];
                    [_textLabel[0] setText:[_scrollingTextArray objectAtIndex:_index]];
                }
                else
                {
                    [_textLabel[1] setFrame:CGRectOffset(_textLabel[1].frame, 2 * CGRectGetWidth(self.bounds), 0.0)];
                    [_textLabel[1] setText:[_scrollingTextArray objectAtIndex:_index]];
                }
            }
                break;
            case ScrollDirectionFromLeftToRight:
            {
                if(_textLabel[0].frame.origin.x >= CGRectGetWidth(self.bounds))
                {
                    [_textLabel[0] setFrame:CGRectOffset(_textLabel[0].frame, -2 * CGRectGetWidth(self.bounds), 0.0)];
                    [_textLabel[0] setText:[_scrollingTextArray objectAtIndex:_index]];
                }
                else
                {
                    [_textLabel[1] setFrame:CGRectOffset(_textLabel[1].frame, -2 * CGRectGetWidth(self.bounds), 0.0)];
                    [_textLabel[1] setText:[_scrollingTextArray objectAtIndex:_index]];
                }
            }
                break;
            case ScrollDirectionFromTopToBottom:
            {
                if(_textLabel[0].frame.origin.y >= CGRectGetHeight(self.bounds))
                {
                    [_textLabel[0] setFrame:CGRectOffset(_textLabel[0].frame, 0.0, -2 * CGRectGetHeight(self.bounds))];
                    [_textLabel[0] setText:[_scrollingTextArray objectAtIndex:_index]];
                }
                else
                {
                    [_textLabel[1] setFrame:CGRectOffset(_textLabel[1].frame, 0.0, -2 * CGRectGetHeight(self.bounds))];
                    [_textLabel[1] setText:[_scrollingTextArray objectAtIndex:_index]];
                }
            }
                break;
            case ScrollDirectionFromBottomToTop:
            {
                if(_textLabel[0].frame.origin.y <= -CGRectGetHeight(self.bounds))
                {
                    [_textLabel[0] setFrame:CGRectOffset(_textLabel[0].frame, 0.0, 2 * CGRectGetHeight(self.bounds))];
                    [_textLabel[0] setText:[_scrollingTextArray objectAtIndex:_index]];
                }
                else
                {
                    [_textLabel[1] setFrame:CGRectOffset(_textLabel[1].frame, 0.0, 2 * CGRectGetHeight(self.bounds))];
                    [_textLabel[1] setText:[_scrollingTextArray objectAtIndex:_index]];
                }
            }
                break;
            default:
                break;
        }
        
        [self startAnimating];
    }
}

// Init text label
- (UILabel *)textLabelWithFrame:(CGRect)frame
{
    UILabel *textLabel = [[UILabel alloc] initWithFrame:frame];
    [textLabel setBackgroundColor:[UIColor clearColor]];
    [textLabel setFont:[UIFont systemFontOfSize:12]];
    [textLabel setLineBreakMode:UILineBreakModeTailTruncation];
    return textLabel;
}

@end
