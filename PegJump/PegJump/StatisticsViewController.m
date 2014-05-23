//
//  StatisticsViewController.m
//  PegJump
//
//  Created by brshapiro on 5/23/14.
//  Copyright (c) 2014 brshapiro. All rights reserved.
//

#import "StatisticsViewController.h"
#import "MainViewController.h"

@interface StatisticsViewController ()

@end

@implementation StatisticsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.wlLabel.text = [NSString stringWithFormat:@"%d/%d",
                         [(MainViewController *)[self parentViewController] wins],
                         [(MainViewController *)[self parentViewController] losses]];
    self.timeLabel.text = [NSString stringWithFormat:@"%f",[(MainViewController *)[self parentViewController] avgTime]];
    self.pegsLabel.text = [NSString stringWithFormat:@"%f",[(MainViewController *)[self parentViewController] avgPegs]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)statSave:(id)sender
{
    [[self parentViewController].view addSubview:((MainViewController *)[self parentViewController]).record];
    [self.view removeFromSuperview];
    [((MainViewController *)[self parentViewController]).record setNeedsDisplay];
}

- (IBAction)statsMenu:(id)sender
{
    [[self parentViewController].view addSubview:[(MainViewController *)[self parentViewController] menuVC].view];
    [self.view removeFromSuperview];
}

@end
