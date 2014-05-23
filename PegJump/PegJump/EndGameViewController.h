//
//  EndGameViewController.h
//  PegJump
//
//  Created by brshapiro on 5/21/14.
//  Copyright (c) 2014 brshapiro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EndGameViewController : UIViewController

@property (nonatomic) BOOL win;
@property (weak,nonatomic) IBOutlet UILabel *winLose;
@property (weak,nonatomic) IBOutlet UIButton *endGame;
@property (weak,nonatomic) IBOutlet UIButton *endMenu;
@property (weak,nonatomic) IBOutlet UIButton *endPrefernces;
@property (weak,nonatomic) IBOutlet UIButton *endStats;
@property (weak,nonatomic) IBOutlet UIButton *endSaves;

-(void) clearView;

@end
