//
//  AppDelegate.m
//  LeftMRight
//
//  Created by Hunk on 12-10-10.
//  Copyright (c) 2012年 Hunk. All rights reserved.
//

#import "AppDelegate.h"

#import "LeftViewController.h"
#import "RightViewController.h"
#import <QuartzCore/QuartzCore.h>

#define OVERVIEW_TAG (10)

@implementation AppDelegate

- (void)dealloc
{
    [_leftViewController release];
    [_rightViewController release];
    [_mainNavigationController release];
    
    [_window release];
    
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    self.window.backgroundColor = [UIColor whiteColor];
    
    // LeftViewController
    _leftViewController = [[LeftViewController alloc] init];
    [_leftViewController setDelegate:self];
    [_leftViewController.view setHidden:YES];
    [self.window addSubview:_leftViewController.view];
    
    // RightViewController
    _rightViewController = [[RightViewController alloc] init];
    [_rightViewController.view setHidden:YES];
    [self.window addSubview:_rightViewController.view];
    
    // MainViewController
    MainViewController *mainViewController = [[MainViewController alloc] init];
    [mainViewController setDelegate:self];
    _mainNavigationController = [[UINavigationController alloc] initWithRootViewController:mainViewController];
    [mainViewController release];
    
    // Add pan gesture recognizer on _mainNavigationController.view
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
    [panGestureRecognizer setMinimumNumberOfTouches:1];
    [panGestureRecognizer setMaximumNumberOfTouches:5];
    [panGestureRecognizer addTarget:self action:@selector(gestureRecognizerAction:)];
    [_mainNavigationController.view addGestureRecognizer:panGestureRecognizer];
    [panGestureRecognizer release];
    
    [self.window addSubview:_mainNavigationController.view];
    [self.window makeKeyAndVisible];
}

- (void)gestureRecognizerAction:(UIPanGestureRecognizer *)panGestureRecognizer
{
    static NSInteger index = 0;
    
    if(panGestureRecognizer.state == UIGestureRecognizerStateBegan)
    {
        if(_mainNavigationController.view.frame.origin.x == 0.0)
        {
            index = 0;
        }
        else if(_mainNavigationController.view.frame.origin.x == 290.0)
        {
            index = 1;
        }
        else if(_mainNavigationController.view.frame.origin.x == -290.0)
        {
            index = 2;
        }
        
        // Set layer atrribute
        [_mainNavigationController.view.layer setShadowColor:[UIColor blackColor].CGColor];
        [_mainNavigationController.view.layer setShadowOpacity:0.4f];
        [_mainNavigationController.view.layer setShadowRadius:4.0f];
        [_mainNavigationController.view.layer setMasksToBounds:NO];
//        if(index == 0 || index == 1)
//        {
//            [_mainNavigationController.view.layer setShadowOffset:CGSizeMake(-12.0f, 1.0f)];
//        }
//        else if(1 == index)
//        {
//        
//        }
//        else
//        {
//            [_mainNavigationController.view.layer setShadowOffset:CGSizeMake(12.0f, 1.0f)];
//        }

        _mainNavigationController.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:_window.bounds].CGPath;
        [_mainNavigationController setNavigationBarHidden:NO];
        
        NSLog(@"index == %ld\n", (long)index);
    }
    else if(panGestureRecognizer.state == UIGestureRecognizerStateChanged)
    {
        CGPoint point = [panGestureRecognizer translationInView:[UIApplication sharedApplication].keyWindow];
        
        if(index == 0)
        {
            if(point.x <= 0)
            {
                [_leftViewController.view setHidden:YES];
                [_rightViewController.view setHidden:NO];
                
                [_mainNavigationController.view.layer setShadowOffset:CGSizeMake(12.0f, 1.0f)];
            }
            else
            {
                [_leftViewController.view setHidden:NO];
                [_rightViewController.view setHidden:YES];
                
                [_mainNavigationController.view.layer setShadowOffset:CGSizeMake(-12.0f, 1.0f)];
            }
        }
        else if(index == 1)
        {

            [_leftViewController.view setHidden:NO];
            [_rightViewController.view setHidden:YES];
            
            [_mainNavigationController.view.layer setShadowOffset:CGSizeMake(-12.0f, 1.0f)];

        }
        else
        {
            [_leftViewController.view setHidden:YES];
            [_rightViewController.view setHidden:NO];
            
            [_mainNavigationController.view.layer setShadowOffset:CGSizeMake(12.0f, 1.0f)];
        }

        CGRect rect = _mainNavigationController.view.frame;
        
        if(index == 0)
        {
            rect.origin.x = 0.0 + point.x;
        }
        else if(index == 1)
        {
            rect.origin.x = 290.0 + point.x;
        }
        else if(2 == index)
        {
            rect.origin.x = -290.0 + point.x;
        }
        
        [_mainNavigationController.view setFrame:rect];
    }
    else if(panGestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        CGRect rect = _mainNavigationController.view.frame;
        
        if(index == 0)
        {
            if(rect.origin.x <= 40.0 && rect.origin.x > 0.0)
            {
                [UIView animateWithDuration:0.2
                                      delay:0.0
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     CGRect rect = _mainNavigationController.view.frame;
                                     
                                     rect.origin.x = 0.0;
                                     
                                     [_mainNavigationController.view setFrame:rect];
                                 } completion:^(BOOL finished) {
                                 }];
            }
            else if(rect.origin.x <= 0.0 && rect.origin.x >= -290.0)
            {
                [UIView animateWithDuration:0.2
                                      delay:0.0
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     CGRect rect = _mainNavigationController.view.frame;
                                     
                                     rect.origin.x = -290.0;
                                     
                                     [_mainNavigationController.view setFrame:rect];
                                 } completion:^(BOOL finished) {
                                 }];
            }
            else
            {
                [UIView animateWithDuration:0.2
                                      delay:0.0
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     CGRect rect = _mainNavigationController.view.frame;
                                     
                                     rect.origin.x = 290.0;
                                     
                                     [_mainNavigationController.view setFrame:rect];
                                 } completion:^(BOOL finished) { 
                                 }];
            }
        }
        else if(1 == index)
        {
            if(rect.origin.x <= 250.0)
            {
                [UIView animateWithDuration:0.2
                                      delay:0.0
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     CGRect rect = _mainNavigationController.view.frame;
                                     
                                     rect.origin.x = 0.0;
                                     
                                     [_mainNavigationController.view setFrame:rect];
                                 } completion:^(BOOL finished) {
                                 }];
            }
            else
            {
                [UIView animateWithDuration:0.2
                                      delay:0.0
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     CGRect rect = _mainNavigationController.view.frame;
                                     
                                     rect.origin.x = 290.0;
                                     
                                     [_mainNavigationController.view setFrame:rect];
                                 } completion:^(BOOL finished) {
                                 }];
            }
        }
        else if(2 == index)
        {
            if(rect.origin.x >= -290.0 && rect.origin.x < -250.0)
            {
                [UIView animateWithDuration:0.2
                                      delay:0.0
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     CGRect rect = _mainNavigationController.view.frame;
                                     
                                     rect.origin.x = -290.0;
                                     
                                     [_mainNavigationController.view setFrame:rect];
                                 } completion:^(BOOL finished) {
                                 }];
            }
            else
            {
                [UIView animateWithDuration:0.2
                                      delay:0.0
                                    options:UIViewAnimationOptionCurveEaseOut
                                 animations:^{
                                     CGRect rect = _mainNavigationController.view.frame;
                                     
                                     rect.origin.x = 0.0;
                                     
                                     [_mainNavigationController.view setFrame:rect];
                                 } completion:^(BOOL finished) {
                                 }];
            }
        }
    }
}

#pragma mark -
#pragma mark mainViewController:didSelectedItemAtIndex:
- (void)mainViewController:(MainViewController *)mainViewController didSelectedItemAtIndex:(NSInteger)index
{
    // Set layer atrribute
    [_mainNavigationController.view.layer setShadowColor:[UIColor blackColor].CGColor];
    [_mainNavigationController.view.layer setShadowOpacity:0.4f];
    [_mainNavigationController.view.layer setShadowRadius:4.0f];
    [_mainNavigationController.view.layer setMasksToBounds:NO];
    [_mainNavigationController.view.layer setShadowOffset:CGSizeMake((0 == index ? -12.0f : 12.0f), 1.0f)];
    _mainNavigationController.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:_window.bounds].CGPath;
    [_mainNavigationController setNavigationBarHidden:NO];
    
    [_leftViewController.view setHidden:(0 == index ? NO : YES)];
    [_rightViewController.view setHidden:(0 == index ? YES : NO)];
    
    [UIView animateWithDuration:0.2f
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         
                         CGRect rect = _mainNavigationController.view.frame;
                         
                         rect.origin.x = (index == 0 ? 290.f : -290.f);
                         
                         [_mainNavigationController.view setFrame:rect];
                     }
                     completion:^(BOOL finished) {
                         
//                         UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] init];
//                         [panGestureRecognizer setMinimumNumberOfTouches:1];
//                         [panGestureRecognizer setMaximumNumberOfTouches:5];
//                         [panGestureRecognizer addTarget:self action:@selector(panGestureRecognizerAction:)];
//                         
//                         UIView *overView = [[UIView alloc] initWithFrame:_mainNavigationController.view.frame];
//                         [overView setBackgroundColor:[UIColor clearColor]];
//                         [overView setTag:OVERVIEW_TAG];
//                         [overView addGestureRecognizer:panGestureRecognizer];
//                         [panGestureRecognizer release];
//                         [[UIApplication sharedApplication].keyWindow addSubview:overView];
//                         [overView release];
                         
                         
                         
                         UIControl *overView = [[UIControl alloc] initWithFrame:_mainNavigationController.view.frame];
                         [overView setBackgroundColor:[UIColor clearColor]];
                         [overView addTarget:self
                                      action:@selector(restoreViewLocation)
                            forControlEvents:UIControlEventTouchDragOutside | UIControlEventTouchUpInside];
                         [overView setTag:OVERVIEW_TAG];
                         [[UIApplication sharedApplication].keyWindow addSubview:overView];
                         [overView release];
                         
                     }];
}


- (void)panGestureRecognizerAction:(UIPanGestureRecognizer *)panGestureRecognizer
{
    if(panGestureRecognizer.state == UIGestureRecognizerStateBegan)
    {

    }
    else if(panGestureRecognizer.state == UIGestureRecognizerStateChanged)
    {
        CGPoint point = [panGestureRecognizer translationInView:[UIApplication sharedApplication].keyWindow];
        
        CGRect rect = _mainNavigationController.view.frame;
        rect.origin.x = 290.0 + point.x;
        [_mainNavigationController.view setFrame:rect];
    }
    else if(panGestureRecognizer.state == UIGestureRecognizerStateEnded)
    {
        CGRect rect = _mainNavigationController.view.frame;

        if(rect.origin.x <= 220.0)
        {
            [UIView animateWithDuration:0.2
                                  delay:0.0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 CGRect rect = _mainNavigationController.view.frame;
                                 
                                 rect.origin.x = 0.0;
                                 
                                 [_mainNavigationController.view setFrame:rect];
                             } completion:^(BOOL finished) {
                                 [self removeCoverView];
                             }];
        }
        else
        {
            [UIView animateWithDuration:0.2
                                  delay:0.0
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 CGRect rect = _mainNavigationController.view.frame;
                                 
                                 rect.origin.x = 290.0;
                                 
                                 [_mainNavigationController.view setFrame:rect];
                             } completion:^(BOOL finished) {
                             }];
        }
    }
}

#pragma mark -
#pragma mark Restore view location
- (void)restoreViewLocation
{
    [UIView animateWithDuration:0.3f
                     animations:^{
                         CGRect rect = _mainNavigationController.view.frame;
                         
                         rect.origin.x = 0.0;
                         
                         [_mainNavigationController.view setFrame:rect];
                     }
                     completion:^(BOOL finished){
                         
                         [self removeCoverView];
                     }];
}

#pragma mark -
#pragma mark leftViewController:didSelectRowAtIndexPath:
- (void)leftViewController:(LeftViewController *)leftViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Set layer atrribute
    [_mainNavigationController.view.layer setShadowColor:[UIColor blackColor].CGColor];
    [_mainNavigationController.view.layer setShadowOpacity:0.4f];
    [_mainNavigationController.view.layer setShadowRadius:4.0f];
    [_mainNavigationController.view.layer setMasksToBounds:NO];
    [_mainNavigationController.view.layer setShadowOffset:CGSizeMake((0 == index ? -12.0f : 12.0f), 1.0f)];
    _mainNavigationController.view.layer.shadowPath = [UIBezierPath bezierPathWithRect:_window.bounds].CGPath;
    [_mainNavigationController setNavigationBarHidden:NO];
    
    [UIView animateWithDuration:0.2f
                          delay:0.0
                        options:UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         CGRect rect = _mainNavigationController.view.frame;
                         
                         rect.origin.x = _mainNavigationController.view.frame.size.width;
                         
                         [_mainNavigationController.view setFrame:rect];
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.2f
                                               delay:0.0f
                                             options:UIViewAnimationOptionCurveEaseIn
                                          animations:^{
                                              CGRect rect = _mainNavigationController.view.frame;
                                              
                                              rect.origin.x = 0.0;
                                              
                                              [_mainNavigationController.view setFrame:rect];
                                          } completion:^(BOOL finished) {
                                              
                                              [self removeCoverView];
                                          }];
                     }];
}

#pragma mark -
#pragma mark Remove cover view
- (void)removeCoverView
{
    UIControl *overView = (UIControl *)[[UIApplication sharedApplication].keyWindow viewWithTag:OVERVIEW_TAG];
    [overView removeFromSuperview];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
