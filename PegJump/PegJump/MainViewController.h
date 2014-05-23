//
//  MainViewController.h
//  PegJump
//
//  Created by brshapiro on 5/21/14.
//  Copyright (c) 2014 brshapiro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuViewController.h"
#import "EndGameViewController.h"
#import "PreferencesViewController.h"
#import "StatisticsViewController.h"
#import "MusicDelegate.h"
#import "GameRecord.h"

@interface MainViewController : UIViewController

@property (strong,nonatomic) MenuViewController *menuVC;
@property (strong,nonatomic) EndGameViewController *endVC;
@property (strong,nonatomic) PreferencesViewController *prefVC;
@property (strong,nonatomic) StatisticsViewController *statVC;

@property (strong,nonatomic) NSString *boardShape;
@property (strong,nonatomic) UIColor *background;
@property (strong,nonatomic) UIColor *pegColor;
@property (strong,nonatomic) NSString *boardTheme;
@property (strong,nonatomic) MusicDelegate *music;

@property (nonatomic) float avgTime;
@property (nonatomic) int wins;
@property (nonatomic) int losses;
@property (nonatomic) float avgPegs;
@property (nonatomic) int games;

@property (strong,nonatomic) GameRecord *record;

-(void)endGame:(float)time : (bool)win : (int)pegs;

@end
