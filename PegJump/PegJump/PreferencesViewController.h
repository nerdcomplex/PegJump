//
//  PreferencesViewController.h
//  PegJump
//
//  Created by brshapiro on 5/22/14.
//  Copyright (c) 2014 brshapiro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DropDownViewController.h"

@interface PreferencesViewController : UIViewController

@property (weak,nonatomic) IBOutlet UIButton *save;
@property (weak,nonatomic) IBOutlet UIButton *cancel;

@property (strong,nonatomic) DropDownViewController *boardShapeSelect;
@property (strong,nonatomic) DropDownViewController *backgroundSelect;
@property (strong,nonatomic) DropDownViewController *pegColorSelect;
@property (strong,nonatomic) DropDownViewController *boardThemeSelect;
@property (strong,nonatomic) DropDownViewController *musicSelect;

@property (strong,nonatomic) DropDownViewController *opened;
@property (strong,nonatomic) UIViewController *returnTo;

@end
