//
//  AnnularProgressView.h
//
//  Created by Hunk on 12-1-6.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnnularProgressView : UIView
{
    CGFloat  _progress;
    
    UIColor *_progressTintColor;
}
/*!
 *  0.0 .. 1.0, default is 0.0.
 */
@property (nonatomic, assign) CGFloat  progress;

/*!
 *  Tint color
 */
@property (nonatomic, retain) UIColor *progressTintColor;


@end
