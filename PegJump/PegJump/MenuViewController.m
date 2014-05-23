//
//  MenuViewController.m
//  PegJump
//
//  Created by brshapiro on 5/21/14.
//  Copyright (c) 2014 brshapiro. All rights reserved.
//

#import "MenuViewController.h"
#import "GameView.h"
#import "MainViewController.h"
#import "PreferencesViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.titleImage setImage:[UIImage imageNamed:@"Black Dot"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menuStartGame:(id)sender {
    if ([[(MainViewController *)[self parentViewController] boardShape] isEqualToString:@"Triangle"]) {
        [[self parentViewController].view addSubview:[[GameView alloc] initWithFrame:self.view.frame :@"Triangle" :5]];
    }
    else if ([[(MainViewController *)[self parentViewController] boardShape] isEqualToString:@"Plus"]) {
        [[self parentViewController].view addSubview:[[GameView alloc] initWithFrame:self.view.frame :@"Plus" :7]];
    }

    [self.view removeFromSuperview];
}

- (IBAction)menuToPreferences:(id)sender {
    [[(MainViewController *)[self parentViewController] prefVC] setReturnTo:self];
    [[self parentViewController].view addSubview:[(MainViewController *)[self parentViewController] prefVC].view];
    [self.view removeFromSuperview];
}

- (IBAction)menuToStatistics:(id)sender {
    [[self parentViewController].view addSubview:[(MainViewController *)[self parentViewController] statVC].view];
    [self.view removeFromSuperview];
}

@end
