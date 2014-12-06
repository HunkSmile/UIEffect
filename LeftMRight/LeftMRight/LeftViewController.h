//
//  LeftViewController.h
//  LeftMRight
//
//  Created by Hunk on 12-10-10.
//  Copyright (c) 2012年 Hunk. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LeftViewControllerDelegate;
@interface LeftViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    UITableView                    *_tableView;
    
    id<LeftViewControllerDelegate>  _delegate;
}
@property (nonatomic, assign) id<LeftViewControllerDelegate> delegate;

@end

@protocol LeftViewControllerDelegate <NSObject>

- (void)leftViewController:(LeftViewController *)leftViewController didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

@end