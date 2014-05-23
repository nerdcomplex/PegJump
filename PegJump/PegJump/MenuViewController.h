//
//  MenuViewController.h
//  PegJump
//
//  Created by brshapiro on 5/21/14.
//  Copyright (c) 2014 brshapiro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController

@property (weak,nonatomic) IBOutlet UIImageView *titleImage;
@property (weak,nonatomic) IBOutlet UIButton *menuGame;
@property (weak,nonatomic) IBOutlet UIButton *menuPreferences;
@property (weak,nonatomic) IBOutlet UIButton *menuStats;

@end
