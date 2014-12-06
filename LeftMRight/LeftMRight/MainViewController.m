//
//  MainViewController.m
//  LeftMRight
//
//  Created by Hunk on 12-10-10.
//  Copyright (c) 2012年 Hunk. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController () <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@end

@implementation MainViewController
@synthesize delegate = _delegate;

- (id)init
{
    if(self = [super init])
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Left
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks
                                                                                       target:self
                                                                                       action:@selector(barButtonItemHandle:)];
    [leftBarButtonItem setTag:0];
    self.navigationItem.leftBarButtonItem = leftBarButtonItem;
    [leftBarButtonItem release];
    
    // Right
    UIBarButtonItem* addBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                      target:self
                                                                                      action:@selector(barButtonItemHandle:)];
    [addBarButtonItem setTag:1];
    self.navigationItem.rightBarButtonItem = addBarButtonItem;
    [addBarButtonItem release];

  
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    [view setBackgroundColor:[UIColor colorWithRed:57/255.0 green:60/255.0 blue:67/255.0 alpha:1]];
    [self.view addSubview:view];
    
    UIView *tempView = [[UIView alloc] initWithFrame:self.view.bounds];
    
    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0.0, 88.0, 320.0, 568-88)];
    [scrollView setPagingEnabled:YES];
    scrollView.bounces = NO;
    for(NSInteger i = 0; i < 5; i++)
    {
        //            UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * CGRectGetWidth(self.bounds), 0.0, CGRectGetWidth(self.bounds), 568-88)];
        //
        //            [view setBackgroundColor:[UIColor brownColor]];
        //            view.layer.borderWidth = 1.0;
        //            view.layer.borderColor = [UIColor redColor].CGColor;
        //            [scrollView addSubview:view];
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(i * CGRectGetWidth(self.view.bounds), 0.0, CGRectGetWidth(self.view.bounds), 568-88)
                                                              style:UITableViewStylePlain];
        [tableView setDelegate:self];
        [tableView setDataSource:self];
        [scrollView addSubview:tableView];
    }
    
    [scrollView setContentSize:CGSizeMake(320.0 * 5, 568-88)];
    [scrollView setDelegate:self];
    [tempView addSubview:scrollView];
    
    [self.view addSubview:tempView];
}

#pragma mark -
#pragma mark UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10.0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(nil == cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{}

- (void)barButtonItemHandle:(id)sender
{
    UIBarButtonItem *barButtonItem = (UIBarButtonItem *)sender;
    
    if(_delegate && [_delegate respondsToSelector:@selector(mainViewController:didSelectedItemAtIndex:)])
    {
        [_delegate mainViewController:self didSelectedItemAtIndex:[barButtonItem tag]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
