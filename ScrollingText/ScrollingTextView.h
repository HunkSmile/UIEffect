//
//  ScrollingTextView.h
//  ScrollingText
//
//  Created by Hunk on 14/12/1.
//  Copyright (c) 2014年 Hunk. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ScrollDirection)
{
    ScrollDirectionFromRightToLeft  = 0,
    ScrollDirectionFromLeftToRight,
    ScrollDirectionFromTopToBottom,
    ScrollDirectionFromBottomToTop
};

@interface ScrollingTextView : UIView
{}

/**
 *  Text array
 *
 *  Default is DefaultScrollingText-1 and DefaultScrollingText-2.
 */
@property (nonatomic, strong) NSArray           *scrollingTextArray;

/**
 *  Scroll direction
 *
 *  Default is ScrollDirectionFromRightToLeft.
 */
@property (nonatomic, assign) ScrollDirection    scrollDirection;

/**
 *  Scroll duration
 *
 *  Default is 2.0 seconds.
 */
@property (nonatomic, assign) NSTimeInterval     duration;

/**
 *  Animating flag
 *  
 *  Default is NO.
 */
@property (nonatomic, assign) BOOL               isAnimating;

/**
 *  Start animating
 *
 *  Before calling this function, set scrollingTextArray, scrollDirection and duration first.
 */
- (void)startAnimating;

/**
 *  Stop animating
 *
 *  @return Stop animating successfully or not.
 */
- (BOOL)stopAnimating;

@end
