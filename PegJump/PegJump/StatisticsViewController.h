//
//  StatisticsViewController.h
//  PegJump
//
//  Created by brshapiro on 5/23/14.
//  Copyright (c) 2014 brshapiro. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StatisticsViewController : UIViewController

@property (weak,nonatomic) IBOutlet UILabel *wlLabel;
@property (weak,nonatomic) IBOutlet UILabel *timeLabel;
@property (weak,nonatomic) IBOutlet UILabel *pegsLabel;
@property (weak,nonatomic) IBOutlet UIButton *save;
@property (weak,nonatomic) IBOutlet UIButton *toMenu;


@end
