//
//  DropDownViewController.m
//
//  Created by brshapiro on 5/22/14.
//  Copyright (c) 2014 Bradley. All rights reserved.
//

#import "DropDownViewController.h"
#import "PreferencesViewController.h"

@interface DropDownViewController()

@end

@implementation DropDownViewController

- (id) init: (NSMutableArray *) options
{
    self = [super init];
    self.options = options;
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, 100, 44)];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    self.tableView.layer.borderWidth = 1;
}

- (void) viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, 44)];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([(PreferencesViewController *)[self parentViewController] opened] != self) {
        return 1;
    }
    return [self.options count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@",[self.options objectAtIndex:indexPath.row]];
    [cell setBackgroundColor:[UIColor clearColor]];
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([(PreferencesViewController *)[self parentViewController] opened] == self) {
        [(PreferencesViewController *)[self parentViewController] setOpened:nil];
        [[self.view superview] setFrame:CGRectMake([self.view superview].frame.origin.x, [self.view superview].frame.origin.y,
                                       [self.view superview].frame.size.width, 62)];
        [self.tableView setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, 100, 44)];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [self.options insertObject:[self.options objectAtIndex:indexPath.row] atIndex:0];
        [self.options removeObjectAtIndex:indexPath.row+1];
    }
    else {
        [[(PreferencesViewController *)[self parentViewController] opened] collapse];
        [(PreferencesViewController *)[self parentViewController] setOpened:self];
        [[self.view superview] setFrame:CGRectMake([self.view superview].frame.origin.x, [self.view superview].frame.origin.y,
                                       [self.view superview].frame.size.width, 62*[self.options count])];
        [self.tableView setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y,
                                       100, 44*[self.options count])];
        [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleSingleLine];
    }
    
    [self.tableView reloadData];
}

- (void) collapse
{
    [[self.view superview] setFrame:CGRectMake([self.view superview].frame.origin.x, [self.view superview].frame.origin.y,
                                               [self.view superview].frame.size.width, 62)];
    [self.view setFrame:CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y,
                                   self.view.frame.size.width, 44)];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    [self.tableView reloadData];
}

- (id) copy
{
    return [[DropDownViewController alloc] init:[self.options copy]];
}

@end
