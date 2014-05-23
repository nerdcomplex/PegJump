//
//  MainViewController.m
//  PegJump
//
//  Created by brshapiro on 5/21/14.
//  Copyright (c) 2014 brshapiro. All rights reserved.
//

#import "MainViewController.h"
#import "MenuViewController.h"
#import "EndGameViewController.h"
#import "PreferencesViewController.h"
#import "StatisticsViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    self.boardShape = @"Triangle";
    self.background = [UIColor whiteColor];
    self.pegColor = [UIColor blueColor];
    self.boardTheme = @"Wooden";
    self.music = nil;
    
    self.avgTime = 0;
    self.wins = 0;
    self.losses = 0;
    self.avgPegs = 0;
    self.games = 0;
    self.record = nil;
    
    self.menuVC = [[MenuViewController alloc] init];
    [self addChildViewController:self.menuVC];
    [self.menuVC didMoveToParentViewController:self];
    [self.view addSubview:self.menuVC.view];
        
    self.endVC = [[EndGameViewController alloc] init];
    [self addChildViewController:self.endVC];
    [self.endVC didMoveToParentViewController:self];
    
    self.prefVC = [[PreferencesViewController alloc] init];
    [self addChildViewController:self.prefVC];
    [self.prefVC didMoveToParentViewController:self];
    
    self.statVC = [[StatisticsViewController alloc] init];
    [self addChildViewController:self.statVC];
    [self.statVC didMoveToParentViewController:self];
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) endGame:(float)time :(bool)win :(int)pegs
{
    self.avgTime = (self.avgTime*self.games + time)/(self.games + 1);
    self.avgPegs = (self.avgPegs*self.games + pegs)/(self.games + 1);

    if (win) {
        self.wins++;
    }
    else {
        self.losses++;
    }
    
    self.games++;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
