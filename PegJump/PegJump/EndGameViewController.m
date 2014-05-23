//
//  EndGameViewController.m
//  PegJump
//
//  Created by brshapiro on 5/21/14.
//  Copyright (c) 2014 brshapiro. All rights reserved.
//

#import "EndGameViewController.h"
#import "MainViewController.h"
#import "GameView.h"

@interface EndGameViewController ()

@end

@implementation EndGameViewController

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
    if (self.win) {
        self.winLose.text = @"You Win";
    }
    else {
        self.winLose.text = @"You Lose";
    }
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)endStartGame:(id)sender {
    if ([[(MainViewController *)[self parentViewController] boardShape] isEqualToString:@"Triangle"]) {
        [[self parentViewController].view addSubview:[[GameView alloc] initWithFrame:self.view.frame :@"Triangle" :5]];
    }
    else if ([[(MainViewController *)[self parentViewController] boardShape] isEqualToString:@"Plus"]) {
        [[self parentViewController].view addSubview:[[GameView alloc] initWithFrame:self.view.frame :@"Plus" :7]];
    }

    [[[self.view superview] superview] removeFromSuperview];
}

- (IBAction)endMainMenu:(id)sender {
    [[self parentViewController].view addSubview:[(MainViewController *)[self parentViewController] menuVC].view];
    [[[self.view superview] superview] removeFromSuperview];
}

- (IBAction)endToPreferences:(id)sender {
    [[(MainViewController *)[self parentViewController] prefVC] setReturnTo:[(MainViewController *)
                                                                             [self parentViewController] menuVC]];
    [[self parentViewController].view addSubview:[(MainViewController *)[self parentViewController] prefVC].view];
    [[[self.view superview] superview] removeFromSuperview];
}

- (IBAction)endSave:(id)sender {
    [(MainViewController *)[self parentViewController] setRecord:[(GameView *)[[self.view superview] superview] recorder]];
    [[self parentViewController].view addSubview:[(GameView *)[[self.view superview] superview] recorder]];
    [[[self.view superview] superview] removeFromSuperview];
}

- (IBAction)endToStatistics:(id)sender {
    [[self parentViewController].view addSubview:[(MainViewController *)[self parentViewController] statVC].view];
    [self.view removeFromSuperview];
}

-(void) clearView
{
    self.view = nil;
}


@end
