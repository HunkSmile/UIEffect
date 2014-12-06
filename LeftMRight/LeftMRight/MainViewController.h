//
//  MainViewController.h
//  LeftMRight
//
//  Created by Hunk on 12-10-10.
//  Copyright (c) 2012年 Hunk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MainViewControllerDelegate;
@interface MainViewController : UIViewController
{
    id<MainViewControllerDelegate> _delegate;
}
@property (nonatomic, assign) id<MainViewControllerDelegate> delegate;

@end

@protocol MainViewControllerDelegate <NSObject>

- (void)mainViewController:(MainViewController *)mainViewController didSelectedItemAtIndex:(NSInteger)index;

@end