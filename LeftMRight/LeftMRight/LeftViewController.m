//
//  LeftViewController.m
//  LeftMRight
//
//  Created by Hunk on 12-10-10.
//  Copyright (c) 2012年 Hunk. All rights reserved.
//

#import "LeftViewController.h"

@interface LeftViewController ()

@end

@implementation LeftViewController
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
    
    // Init UITableView
    CGRect rect = self.view.bounds;
    rect.size.width = rect.size.width - 30.0;
    _tableView = [[UITableView alloc] initWithFrame:rect style:UITableViewStylePlain];
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    [self.view addSubview:_tableView];
}

#pragma mark -
#pragma mark UITableViewDataSource methods
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if(cell == nil)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                      reuseIdentifier:cellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate method
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(_delegate && [_delegate respondsToSelector:@selector(leftViewController:didSelectRowAtIndexPath:)])
    {
        [_delegate leftViewController:self didSelectRowAtIndexPath:indexPath];
    }
}

#pragma mark -
#pragma mark dealloc
- (void)dealloc
{
    [_tableView release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
