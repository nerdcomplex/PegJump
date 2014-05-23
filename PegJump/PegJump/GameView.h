//
//  GameView.h
//  PegJumper
//
//  Created by Adham Meguid on 5/18/14.
//  Copyright (c) 2014 Organization XIII. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PegData.h"
#import "GameRecord.h"

@interface GameView : UIView

@property (strong,nonatomic) PegData *data;
@property (strong,nonatomic) NSArray *possibleMoves;
@property (strong,nonatomic) NSArray *currentPeg;
@property (nonatomic) BOOL started;
@property (strong,nonatomic) GameRecord *recorder;
@property (strong,nonatomic) NSTimer *timer;
@property (nonatomic) int time;

- (id)initWithFrame:(CGRect)frame : (NSString *) shape : (int) size;
- (id)initShortCut:(CGRect)frame : (PegData *)data;
- (void) startTimer;

@end
