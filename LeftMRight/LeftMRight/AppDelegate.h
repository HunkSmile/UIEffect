//
//  AppDelegate.h
//  LeftMRight
//
//  Created by Hunk on 12-10-10.
//  Copyright (c) 2012年 Hunk. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LeftViewController.h"
#import "MainViewController.h"

@class LeftViewController;
@class RightViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate, LeftViewControllerDelegate, MainViewControllerDelegate>
{
    LeftViewController     *_leftViewController;
    
    RightViewController    *_rightViewController;
    
    UINavigationController *_mainNavigationController;
}

@property (strong, nonatomic) UIWindow *window;

@end
